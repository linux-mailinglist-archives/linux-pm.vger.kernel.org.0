Return-Path: <linux-pm+bounces-35526-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137FDBA779B
	for <lists+linux-pm@lfdr.de>; Sun, 28 Sep 2025 22:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B9B3B8FC9
	for <lists+linux-pm@lfdr.de>; Sun, 28 Sep 2025 20:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A1822A4FE;
	Sun, 28 Sep 2025 20:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GMr3OeS0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB1B2236F7
	for <linux-pm@vger.kernel.org>; Sun, 28 Sep 2025 20:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759091979; cv=none; b=NwbVcvr2dWi4u2Xg1y1/r/KDNgR1PESAqYZ3PVeuJ77Yp1k1Lr9CVQxvyKsMjRatHeQ13ndwcQZbEsQUiqxPEA6zKELn5klAewGT0zA5RlewI5CPbC18/ULlxBzjROINaD1VgyRjt0PHaUD4TT2RwNsOyJGz9r/TcO1LuqrMawg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759091979; c=relaxed/simple;
	bh=bEBztlDiDQm5yl4Shpm/wje5Q6Z0JaMNh9bKKhDYN3o=;
	h=Content-Type:Message-ID:Date:MIME-Version:To:Cc:From:Subject; b=DYCEmbm3xwT29sctTOoFIC87bNIawTxr7aKNEBbCkn4PKHV5dEsPGh92OqLKfLBglVqyo/BTraGLYaLToiPuWEDpisg50NlR/UBTABjWvn8WRa6pmF9dGXIvmLc8LDJMjcJeyonxy1+gX3Fhb1Do+vNZzS7k4TnevehxPWf2uMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GMr3OeS0; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-92493f9715fso6865839f.2
        for <linux-pm@vger.kernel.org>; Sun, 28 Sep 2025 13:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1759091977; x=1759696777; darn=vger.kernel.org;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0GMHj9QDikQRS38Qefu4a7ROoXVLSiqxW3Ec8xSrjSM=;
        b=GMr3OeS0rFgk+nf4T1WV4TJi/4xIwo8S+5VRF2uK+pD+ytvX3+YRu3+bmbzbWbHH7X
         cdurp/IalrWZ0Gss04AGQYVMd8Ro/nbjaVfB8ZtjBHVGbPvfVv+0dd82qqDvT1Frq+p9
         s/ElrnVCOvUiffXzrkdTyGnQmq4Rm9EqWjTU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759091977; x=1759696777;
        h=subject:from:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GMHj9QDikQRS38Qefu4a7ROoXVLSiqxW3Ec8xSrjSM=;
        b=B1KC09gxyLssmDxCn8s8d/pTfD1KgmpiYbZG8aRsoHQa32aoJ3hd928mXXTXd+RWt6
         O/1DhBObX3ZXpi1tsIeV7Cf96EQjCX7v++GqvyMGjbwaWOzEi3zenoWwzPVaN3orhEBl
         8qsgOcKvpsbpv7ucior8ztZ9jny6vc4yrJydEkjhTdghP6e+sNEgWuooOOWkp1Vwo3fx
         1S10EbWsorgVIEkEVt9yyjYxmMhfQhZUHy0c1BUt1Rp0BpZ3NO8tvgXiGp0FDgvmKo6R
         PJtrwb8WRezbwDEGD1W1owF+kELeXY2V0RocrZYsVjxlXOKTbvKn+ikgikOZMfanpPY5
         Ry7w==
X-Forwarded-Encrypted: i=1; AJvYcCVHqn+WEsn87fJSAFpEIaLh+CMSo9VmIhtSVvbN0/paN4u//JN3Q/ZYezr+gttmmSEcSQpeY+9+ng==@vger.kernel.org
X-Gm-Message-State: AOJu0YyPGUCn6plfX89CKDofbjSFOJBVamt4XTPFRSKZgeQrc3Dx2wA7
	pcFQ1q2OaXt19LWOZsRvN/E95lL3uYdG9+hvOgFdpeyESNeqdmzhzXI/B+qY+pBK4O4=
X-Gm-Gg: ASbGncvhlU5bf+Y7u4tYh6hzdbVfa65+20ydf9rvVSzIwUNP+U9k6ZXWwvt3T1vPjRB
	xDVojBChQNvUAjUIPlpE1h/7wET0GKrPcr8YqrT8yL8x+7f9INudrbhvp+DiH2hDI1KzG1CRGy5
	SLC0GLxEOByPLXpU4CRNEL47NJW789ts4JSjZRWTHBzZ6/8K2708wV+pl6Am2Dy+HIidP/pR/01
	PfYsUmopJqB8q9LwMnzAEwacmvO2gfrQnC+0DFyUvmbsUMdChVdhwr4gQITv6Q2LTqQicEoT/lj
	D18VbNKyj0QGdrJ9mtRYRUhGT1vjYq5IERLYgjcshfOImrHpir4D+B+7FYOYScr00u7kYDXjEvd
	0Y02ZLHKvBtvnb3GWxY9fn5VumYlKGf+aLIHFSu0bfLfrVw==
X-Google-Smtp-Source: AGHT+IEbapQwyVOIgQ7km870dTxBRRVMMKUVzWINYLoJVskCwQrcQoBqjUDru19B/4RkCmqucnthFQ==
X-Received: by 2002:a05:6602:1686:b0:8eb:13e6:aed9 with SMTP id ca18e2360f4ac-90162bb6fbbmr2108581839f.12.1759091976931;
        Sun, 28 Sep 2025 13:39:36 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-9040fb05680sm369789639f.24.2025.09.28.13.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Sep 2025 13:39:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------K1Lbt0IglnwyAgKWGOxXakbd"
Message-ID: <72b9ae1e-18a4-4b59-9c01-1248c38eee43@linuxfoundation.org>
Date: Sun, 28 Sep 2025 14:39:35 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: shuah <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Thomas Renninger <trenn@suse.com>, Thomas Renninger <trenn@suse.de>,
 "John B. Wyatt IV" <jwyatt@redhat.com>, John Kacur <jkacur@redhat.com>,
 Linux PM <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] cpupower update for Linux 6.18-rc1

This is a multi-part message in MIME format.
--------------K1Lbt0IglnwyAgKWGOxXakbd
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rafael,

Please pull the following cpupower update for Linux 6.18-rc1.

Fixes incorrect return vale in cpupower_write_sysfs() error path
and passing incorrect size to cpuidle_state_write_file() while
writing status to disable file in cpuidle_state_disable().

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit f83ec76bf285bea5727f478a68b894f5543ca76e:

   Linux 6.17-rc6 (2025-09-14 14:21:14 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux tags/linux-cpupower-6.18-rc1

for you to fetch changes up to 23199d2aa6dcaf6dd2da772f93d2c94317d71459:

   tools/cpupower: Fix incorrect size in cpuidle_state_disable() (2025-09-24 17:15:35 -0600)

----------------------------------------------------------------
linux-cpupower-6.18-rc1

Fixes incorrect return vale in cpupower_write_sysfs() error path
and passing incorrect size to cpuidle_state_write_file() while
writing status to disable file in cpuidle_state_disable().

----------------------------------------------------------------
Kaushlendra Kumar (2):
       tools/cpupower: fix error return value in cpupower_write_sysfs()
       tools/cpupower: Fix incorrect size in cpuidle_state_disable()

  tools/power/cpupower/lib/cpuidle.c  | 5 +++--
  tools/power/cpupower/lib/cpupower.c | 2 +-
  2 files changed, 4 insertions(+), 3 deletions(-)
----------------------------------------------------------------
--------------K1Lbt0IglnwyAgKWGOxXakbd
Content-Type: text/x-patch; charset=UTF-8; name="linux-cpupower-6.18-rc1.diff"
Content-Disposition: attachment; filename="linux-cpupower-6.18-rc1.diff"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2xpYi9jcHVpZGxlLmMgYi90b29s
cy9wb3dlci9jcHVwb3dlci9saWIvY3B1aWRsZS5jCmluZGV4IDBlY2FjMDA5MjczYy4uZjJj
MTEzOWFkZjcxIDEwMDY0NAotLS0gYS90b29scy9wb3dlci9jcHVwb3dlci9saWIvY3B1aWRs
ZS5jCisrKyBiL3Rvb2xzL3Bvd2VyL2NwdXBvd2VyL2xpYi9jcHVpZGxlLmMKQEAgLTIzMyw2
ICsyMzMsNyBAQCBpbnQgY3B1aWRsZV9zdGF0ZV9kaXNhYmxlKHVuc2lnbmVkIGludCBjcHUs
CiB7CiAJY2hhciB2YWx1ZVtTWVNGU19QQVRIX01BWF07CiAJaW50IGJ5dGVzX3dyaXR0ZW47
CisJaW50IGxlbjsKIAogCWlmIChjcHVpZGxlX3N0YXRlX2NvdW50KGNwdSkgPD0gaWRsZXN0
YXRlKQogCQlyZXR1cm4gLTE7CkBAIC0yNDEsMTAgKzI0MiwxMCBAQCBpbnQgY3B1aWRsZV9z
dGF0ZV9kaXNhYmxlKHVuc2lnbmVkIGludCBjcHUsCiAJCQkJIGlkbGVzdGF0ZV92YWx1ZV9m
aWxlc1tJRExFU1RBVEVfRElTQUJMRV0pKQogCQlyZXR1cm4gLTI7CiAKLQlzbnByaW50Zih2
YWx1ZSwgU1lTRlNfUEFUSF9NQVgsICIldSIsIGRpc2FibGUpOworCWxlbiA9IHNucHJpbnRm
KHZhbHVlLCBTWVNGU19QQVRIX01BWCwgIiV1IiwgZGlzYWJsZSk7CiAKIAlieXRlc193cml0
dGVuID0gY3B1aWRsZV9zdGF0ZV93cml0ZV9maWxlKGNwdSwgaWRsZXN0YXRlLCAiZGlzYWJs
ZSIsCi0JCQkJCQkgICB2YWx1ZSwgc2l6ZW9mKGRpc2FibGUpKTsKKwkJCQkJCSAgIHZhbHVl
LCBsZW4pOwogCWlmIChieXRlc193cml0dGVuKQogCQlyZXR1cm4gMDsKIAlyZXR1cm4gLTM7
CmRpZmYgLS1naXQgYS90b29scy9wb3dlci9jcHVwb3dlci9saWIvY3B1cG93ZXIuYyBiL3Rv
b2xzL3Bvd2VyL2NwdXBvd2VyL2xpYi9jcHVwb3dlci5jCmluZGV4IGNlOGRmYjhlNDZhYi4u
ZDdmN2VjNmYxNTFjIDEwMDY0NAotLS0gYS90b29scy9wb3dlci9jcHVwb3dlci9saWIvY3B1
cG93ZXIuYworKysgYi90b29scy9wb3dlci9jcHVwb3dlci9saWIvY3B1cG93ZXIuYwpAQCAt
NTYsNyArNTYsNyBAQCB1bnNpZ25lZCBpbnQgY3B1cG93ZXJfd3JpdGVfc3lzZnMoY29uc3Qg
Y2hhciAqcGF0aCwgY2hhciAqYnVmLCBzaXplX3QgYnVmbGVuKQogCWlmIChudW13cml0dGVu
IDwgMSkgewogCQlwZXJyb3IocGF0aCk7CiAJCWNsb3NlKGZkKTsKLQkJcmV0dXJuIC0xOwor
CQlyZXR1cm4gMDsKIAl9CiAKIAljbG9zZShmZCk7Cg==

--------------K1Lbt0IglnwyAgKWGOxXakbd--

