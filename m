Return-Path: <linux-pm+bounces-16156-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E31DF9A9355
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 00:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 689271F21FCD
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2024 22:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155C919CC24;
	Mon, 21 Oct 2024 22:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjcs2isI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2551E283F
	for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729549811; cv=none; b=NluzC48XV0k152Gi8U9ePvlXu9wIr6h2enetfCQVpbRkZqBTaypooP6eLzuCwoGB4Q8bcuLYxZWPYwggWXB0Tev7gL9uXIQ6SjEGxgo68smgb19Gyy/cHAwZ77IIhBREqJF6pWiXd60IVlWSHipRaVGfrb5++ENe8HtybsqQerY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729549811; c=relaxed/simple;
	bh=C2C68GMIxq852cFa9pbvn2pwWeXbpGGd+1/8mY3iUKE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ModtzuMC5m9PM4/+dcFtDUsNQ5iCbaFmqHY6a16dENOQxRrs+kMkquu+QAlbCrWMT94h8Z0xoeTovbHwfIjwleIDQ8WeiasCQjP244DGRGR5Qauy0lLRkBAm7kVv9hkwDUustmU4mkpYF7F3eXjzDn7sSXrgwf0wXDnqNZqhEZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjcs2isI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43152b79d25so48190225e9.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Oct 2024 15:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729549808; x=1730154608; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNJzzDLVafZi+aocwsPQQzFoOmb4MtQ2aHn/vcpxx9M=;
        b=cjcs2isIRJggjUljhO61VkKSQV1IRW91qdc//Q9pP+wNBNjNyyppDX73etnXIiy47o
         4RGADJ4oUUCWRS29oVAVW5K6H3EjP9ihPfLU92xWQCdXX1/ZXLNXxVslBsP9zJN45TLF
         ePCpKKoRyLoyLyM73eX9ScI3cfkLul8FjBo0Gggqv/ukOWZs6zP5+v8gR3LutXrSujZE
         VXO3XWG3BGzqtgB7nZk1hi2H6vJ30dZG1Lo3mu3ImQAC3IDIX6XtwokP1Ssr95lgRBe3
         oh92a+ONCHki7m45xkPKXlDpIAiJWF4ijoC5K/GGrwwHaWZRw1y64D+DLXGJYbz7mMvi
         VEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729549808; x=1730154608;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wNJzzDLVafZi+aocwsPQQzFoOmb4MtQ2aHn/vcpxx9M=;
        b=mtHOkkc4r1/GEPY25i9gOhdRHOFB7putI7eUyy8XoV0U6FJkSqouZPuH7QvhFeh1sY
         i3zOuPuFFTc8A0WMsHACE6cvxA8oo5tL9MW1fwGRbLMhr6WDzxyDhATy2L4U79DcOSjB
         LSL5cgiPuN74/zycJDr3e30ruhrKXWyJ5/kGKOEr0qYjt+cWIPc+/O3Qhn3BaMXBCmVb
         m4oW6HSIK02Dr4mQqu8ul3Khou++8R3qQI41e07irgnfx6Bbt3mY3eJfqVqGBST06BmU
         KAUTDD5NED2ok/kJ+I/Q7wOzkRF0EvCnaxM9p9nwAd3+W3s7bXAVl0BKC4yStZpVB2Bg
         jlDQ==
X-Gm-Message-State: AOJu0Yx9fZGQRkQhLXZwnSe+nyXBUq9uLH1apT8eExisU8R1q4KKxXxk
	lAzVXQq2+hrUra69LG6hh+Y89R35DZm47KA2D0VBuJojv4976+U5
X-Google-Smtp-Source: AGHT+IHTYU0eAiZYqb51Tl2NnqBz3uqKNSAf5VRoWhSnOQP2n3J11ktqtmOW/5A3Obs4QNoADC5T7A==
X-Received: by 2002:a05:600c:4f8f:b0:431:3c67:fb86 with SMTP id 5b1f17b1804b1-4317cb096d5mr3751235e9.33.1729549807648;
        Mon, 21 Oct 2024 15:30:07 -0700 (PDT)
Received: from [192.168.1.248] ([194.120.133.34])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4316f58f1fdsm69735405e9.28.2024.10.21.15.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 15:30:07 -0700 (PDT)
Message-ID: <6f78a1ba-23a7-4676-b9be-06d632bbf3ea@gmail.com>
Date: Mon, 21 Oct 2024 23:30:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Markus Mayer <mmayer@broadcom.com>,
 bcm-kernel-feedback-list@broadcom.com, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: linux-pm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-pm@vger.kernel.org
From: "Colin King (gmail)" <colin.i.king@gmail.com>
Subject: cpufreq: brcmstb-avs-cpufreq: issue with error number check that's
 always true
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

There seems to be a logic issue with the rc comparisons in the following 
function in drivers/cpufreq/brcmstb-avs-cpufreq.c

/*
  * To ensure the right firmware is running we need to
  *    - check the MAGIC matches what we expect
  *    - brcm_avs_get_pmap() doesn't return -ENOTSUPP or -EINVAL
  * We need to set up our interrupt handling before calling 
brcm_avs_get_pmap()!
  */
static bool brcm_avs_is_firmware_loaded(struct private_data *priv)
{
         u32 magic;
         int rc;

         rc = brcm_avs_get_pmap(priv, NULL);
         magic = readl(priv->base + AVS_MBOX_MAGIC);

         return (magic == AVS_FIRMWARE_MAGIC) && ((rc != -ENOTSUPP) ||
                 (rc != -EINVAL));
}

..the following condition is always true:

       ((rc != -ENOTSUPP) || (rc != -EINVAL))


.. because rc cannot be equal to two different values at the same time, 
so it must be not equal to at least one of them.

This was introduced with commit:

commit 22a26cc6a51ef73dcfeb64c50513903f6b2d53d8
Author: Florian Fainelli <f.fainelli@gmail.com>
Date:   Wed May 22 11:45:46 2019 -0700

     cpufreq: brcmstb-avs-cpufreq: Fix initial command check

     There is a logical error in brcm_avs_is_firmware_loaded() whereby 
if the
     firmware returns -EINVAL, we will be reporting this as an error. The
     comment is correct, the code was not.


..the commit message seems to rely on the logic expressed in the 
comment, but I think the "or" used in the comment is not equivalent to 
the English grammatical use of "or". I suspect the commit is incorrect 
and needs reverting/fixing.

Colin

