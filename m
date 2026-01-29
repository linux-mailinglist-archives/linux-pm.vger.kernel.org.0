Return-Path: <linux-pm+bounces-41727-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAQ4LrvEe2mDIQIAu9opvQ
	(envelope-from <linux-pm+bounces-41727-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 21:36:11 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0E7B4433
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 21:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8BABE3006693
	for <lists+linux-pm@lfdr.de>; Thu, 29 Jan 2026 20:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718F0353EE1;
	Thu, 29 Jan 2026 20:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fib6nBEs"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7A425D216
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 20:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769718969; cv=none; b=JNXCcwlD3CRmX5ahbyK2Nqp0R2q1/gM4vpXXDqfzzivZbvYqhKiXu+wx24gGanDsDbqNi79S/A0mKMAJcqR6P5lQ9hipa7m/0oVIan8f3i7tmYP4n5i4aUBZkVfNQAmRgJPMBIwbhZaj25q9xdd6Xiz2sQZyitK2sx8cvBnMYtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769718969; c=relaxed/simple;
	bh=L0i4dutf5AiMu4GpfMDW0LGClTYl4iN50p1ELMfUrFU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SjIjge1gVof8pBWfe07fKodarvXwflbV8S+QKYiQ/x8Uwtw1XdATOYeg+1T3JT8arOBu4QqVvU4i14DZ0kocFzvSJM6LpXVe9qiqUoVtuMHqD8B9LROIv5awkAGz9VVVxcnfX6SRspP0bcdyq4Paq7o8QswLmU2PNxcUSyUFk+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fib6nBEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD655C2BC86
	for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 20:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769718968;
	bh=L0i4dutf5AiMu4GpfMDW0LGClTYl4iN50p1ELMfUrFU=;
	h=From:Date:Subject:To:Cc:From;
	b=fib6nBEsX6FrTFoay/5PodPE3V90js+g0q6hpD+LHlEuuZYVixZjpmWbRAnGEqyUl
	 NaoDTAMoOiBZjczeGDN3+oyMiF6ZWsiEuzuN4k78VtzceMduEuwosfzn3qSABFhBv0
	 rK/EIuFvVktYKuhODfxJkIrS0/qk6DjredUWCMHf/KwqKHXl208ibgG3/e+JxT8cP8
	 Tc5t5Iuozehx5avUr/g/soWc1x/BzvSxQCNGKoOP1jdM/3lViVxVS7x6dMUOb6wU9p
	 FKcae4JT8q1/NFLTDoI1WTdPIhzrAiawQMapzFKvl9+HDCkc1SSLOBEt52mtksCPsf
	 ThE6Zbrg/u9RA==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-662f54771dcso509060eaf.2
        for <linux-pm@vger.kernel.org>; Thu, 29 Jan 2026 12:36:08 -0800 (PST)
X-Gm-Message-State: AOJu0YyGoAbmKr6nxk5x4ZMK8/kjmHj+/dG1wJVHFoUiirA9IZUFNa/D
	MZqgZZ/c8rNCxUPJAs5rJJp3vpNCu5iA518lAqi+ZYGv93vyFdxMAA4u1DRf8avBwJUyGdTTnPN
	CdaED4NSsPO6g44r6CrVD8Nn/UFGB5iI=
X-Received: by 2002:a05:6820:22a0:b0:663:e9e:c66e with SMTP id
 006d021491bc7-6630f358125mr380323eaf.40.1769718967837; Thu, 29 Jan 2026
 12:36:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 29 Jan 2026 21:35:57 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jNT2zChGFdwx9PNx6W1Vk+Mp69dFEos4YLSGgN6gUp7g@mail.gmail.com>
X-Gm-Features: AZwV_QifEsiyVH8SDpjLQDp_js2_BBI3D4hghCCgBDotAmUJo2R6Jc5eCj1HcQE
Message-ID: <CAJZ5v0jNT2zChGFdwx9PNx6W1Vk+Mp69dFEos4YLSGgN6gUp7g@mail.gmail.com>
Subject: [GIT PULL] Power management fix for v6.19-rc8
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-41727-lists,linux-pm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafael@kernel.org,linux-pm@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pm];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A0E7B4433
X-Rspamd-Action: no action

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-6.19-rc8

with top-most commit 1730daa3b425ea8c88ae599af6e1a4957bd2d81a

 Merge tag 'cpufreq-arm-fixes-6.19-rc8' of
git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm

on top of commit 63804fed149a6750ffd28610c5c1c98cce6bd377

 Linux 6.19-rc7

to receive a power management fix for 6.19-rc8.

This adds a terminating NULL entry to an of_device_id table in the
qcom-nvmem cpufreq driver to avoid out-of-bounds access (Pei Xiao).

Thanks!


---------------

Pei Xiao (1):
      cpufreq: qcom-nvmem: add sentinel to qcom_cpufreq_ipq806x_match_list

---------------

 drivers/cpufreq/qcom-cpufreq-nvmem.c | 1 +
 1 file changed, 1 insertion(+)

