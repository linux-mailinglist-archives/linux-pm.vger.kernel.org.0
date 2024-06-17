Return-Path: <linux-pm+bounces-9275-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BDD590A3A9
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 08:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAF2B281CBC
	for <lists+linux-pm@lfdr.de>; Mon, 17 Jun 2024 06:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A05181D1F;
	Mon, 17 Jun 2024 06:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iMHH8l/m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8C2181315
	for <linux-pm@vger.kernel.org>; Mon, 17 Jun 2024 06:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718604319; cv=none; b=LsX4GLB/TRM/K9jmUpKQZIEW3GueO+mKupN+Bj9pUyTuRCCebtd07ZWtxTY1lFyBSZsc9eZUGB1XZNqq1Nm8QoW3CaUtspB7igelZHcvhPeS6bxU8/fdpi0tybVNAjlbVX/2OVRJvmaTDIDTMvU0OYkLoBjrNWyfj4QsZgYZ7lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718604319; c=relaxed/simple;
	bh=PgB8PKxsUEKNt+HMslFfmvHOaixSE52IyADVaN7ur/A=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=dBCOvW1AzSd3K21l3D4WYOzXEwMwwHczfdajBbRk0bUIFicsejmTIeZfCSvgUMpnm/TyrOzvSmPTE+BBb0PgmWHLOCsmMME+Wt77uQ4xoIBm2+VhIVCe6rDQeMfQR3hyVVT4dLVVuLD2/69e4DvtW9rDXmpOl6Yyr2D34muYjNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iMHH8l/m; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4217a96de38so29337635e9.1
        for <linux-pm@vger.kernel.org>; Sun, 16 Jun 2024 23:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718604316; x=1719209116; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zS1aeYgKyINpCmSdi/HNQLP7zJXBRqIlSyG7kOUcoOw=;
        b=iMHH8l/mlNR3WpAIm7z2x6tsPZAA+UOFAJP/n9PcacBn+gljoLb374jTzTEVEGLUdL
         MVAqBmHjYnotsy4yFa+eqsuQaZLeZIfrZjRNsPCxA++HuOlHVKflkgZmtaozWhxhHhpT
         AZ1PJ/8D1J9Kz6BWF8sIRZ+nAunVqs4HqS+VnZjxpggkKm8BBASF0kOrEP4UJM9ot1Po
         w26Zs/c9DazUdgKPW6QTzcPxVL9o4BS1nvskqy7v995o3dWdgcjB5dF3POOgr/nSKECc
         aW/jFJbMp91wdUCQPqF6+lokRoTDP8hYfP5/xDMkYPC2HFyl3R7rHRrpsY8b2QQMGnvB
         qFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718604316; x=1719209116;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zS1aeYgKyINpCmSdi/HNQLP7zJXBRqIlSyG7kOUcoOw=;
        b=Tc/ZM4ji5gmEFK2xb782mvrUD1mGyCPQOM4kfm9nE7a0Qydlefp9ZhC1oHxln1QwsM
         xqHs4nFa9123//D7bZkCOwXvhqZ/GWU678b5Iyb3R2fzi1TylD6NnJT67r2kM73Bpbs8
         +97dpZ3CMA77ccNU7hjy7TRBIywan/wHiUWGXI+t4Pcms9DIxKmRlZsirLjK5uGvT+6T
         kKNGRM6JIEeOke2UkshFvC+7ecnREMZ3scIf1BkX6hLjqzgFG8Suct7RVOPi8kKGTorh
         M0VrRS7u3B7SG2W0cm2f/m4PG2QVrYo+AqMzn8SzS+zQPoCBHC0WeyfBU6xzgXp50Gr8
         Powg==
X-Gm-Message-State: AOJu0YzIxC5lsS/OJCVaTsh4VrZJGxrBc2HN0Du6vWTcypb3npMSimt/
	o68Kt3zPO5eapoalb6JwGsAUa+TNCOWeVyr4SpjS7PZ2Hl9GIzILzG8IUiGCJ9E=
X-Google-Smtp-Source: AGHT+IEEC9UP8MOlrevAVHI4nYGV9kvIzUOUfp5mXwsv6sR7/laYuBTI0iC3ozJcCUzvDqnyGDvMLQ==
X-Received: by 2002:a7b:ce97:0:b0:423:b6cd:8ea5 with SMTP id 5b1f17b1804b1-423b6cd8fcemr38477465e9.4.1718604315680;
        Sun, 16 Jun 2024 23:05:15 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7a26:54f4:ac69:a55b? ([2a05:6e02:1041:c10:7a26:54f4:ac69:a55b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42286fe9263sm185486905e9.15.2024.06.16.23.05.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jun 2024 23:05:15 -0700 (PDT)
Message-ID: <8e082c01-d0b4-46e4-bae3-0e7ea89be800@linaro.org>
Date: Mon, 17 Jun 2024 08:05:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>,
 Julien Panis <jpanis@baylibre.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] thermal drivers fixes for v6.10-rc4
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Rafael,

please consider pulling the following changes since commit 
c3f38fa61af77b49866b006939479069cd451173:

   Linux 6.10-rc2 (2024-06-02 15:44:56 -0700)

are available in the Git repository at:

 
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v6.10-rc4

for you to fetch changes up to 72cacd06e47d86d89b0e7179fbc9eb3a0f39cd93:

   thermal/drivers/mediatek/lvts_thermal: Return error in case of 
invalid efuse data (2024-06-12 19:07:34 +0200)

----------------------------------------------------------------
- Remove the filtered mode for mt8188 as it is not supported on this
   platform (Julien Panis)

- Fail in case the golden temperature is zero as that means the efuse
   data is not correctly set (Julien Panis)

----------------------------------------------------------------
Julien Panis (2):
       thermal/drivers/mediatek/lvts_thermal: Remove filtered mode for 
mt8188
       thermal/drivers/mediatek/lvts_thermal: Return error in case of 
invalid efuse data

  drivers/thermal/mediatek/lvts_thermal.c | 12 +++++-------
  1 file changed, 5 insertions(+), 7 deletions(-)

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

