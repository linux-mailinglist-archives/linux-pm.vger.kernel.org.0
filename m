Return-Path: <linux-pm+bounces-27534-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FEDEAC1742
	for <lists+linux-pm@lfdr.de>; Fri, 23 May 2025 01:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EF233A36B8
	for <lists+linux-pm@lfdr.de>; Thu, 22 May 2025 23:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EFD32C178D;
	Thu, 22 May 2025 23:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HN6FeF2M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589052C0304
	for <linux-pm@vger.kernel.org>; Thu, 22 May 2025 23:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747955102; cv=none; b=tRUs4VZR3buT8Rqe0RFR3fir/NvTqOEdBwdcBpF3NwmBcUGfZjK54VhtWplZIjlWgmQDfqBVjsZjdiIhy1IQ1tho2w8iWRFauwG/woafmI/QK9rbDzgLhMp+zmmIycaPdX8W9avKVS7f7ZtlpAFSSREAB/o4I4sMwTARKXnCFys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747955102; c=relaxed/simple;
	bh=lScQnSCkvuRBtECCWLHIYCv8vmN77MwE39G4+WsfwoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LIHNiVqmkFh1O2ZzHXPT7yHUO140nrJdE8x/lRRvbYZezzJCfxLJHKbWSmIkBz7u1qk/Ln42Xb6at9ckHcCKOTvkiDnPHG3lhzzYMTuWdO0Ot76UBXKwdVzLpDN1545m9W8sAfGnFlN3YSFWGpjbeNyz0wdSiUHrhM23aO34eb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HN6FeF2M; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3dc64b08343so26304505ab.2
        for <linux-pm@vger.kernel.org>; Thu, 22 May 2025 16:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747955098; x=1748559898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NyQ/Gx89Cr5NXHdPsJF5IueYH71HqlFunPxqtl/qLjg=;
        b=HN6FeF2MiC7fFEHxmFsL6OL6b6NBiQo8Y/2heghsL9cCi8xfqaHkmy96L7K8oBrjfz
         JSx96lKxpQjStR99tr9QocdPVXinuga4F2ar22XhSm4QHMY7a4uNE5jWDLrtoRZ3uZnc
         38Te2I2VK1OaZv6w4DPMrEDVHF9gnjzNzf8xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747955098; x=1748559898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NyQ/Gx89Cr5NXHdPsJF5IueYH71HqlFunPxqtl/qLjg=;
        b=NfTGXLru4AHu0zBTNgcZyQOiIie6Hh+a9XcIYncTJGCtVTZQSG1W6EKpM2lNzEBuql
         ooki6WAm1nQw2Brmn8sqpfuLktA6Lgo2mOqnIl7wylKN0glCvLiU+BKhUIXC4DMYd6OZ
         WZ4rTTHsx5px+2Rks77RtLQxhxTK9SfnDelcBhexKOSEQJ2K06hkOlyw/RHki5Aw9IpO
         Jvt7KwV6A+IRyYH/b+CyP8JN3C/zm3M/vo/Pu6/RwtRjsCBYASYnSESq0kVFLxTAsbBb
         r74/zPRQYGseu3p89Y6qW9FSCFuUtOax/6IGlcdsH19VfS/F/NL0sf2ExJyCfGeTXlV8
         r2ZA==
X-Forwarded-Encrypted: i=1; AJvYcCWnob37YFrJgOTghPYRCrHGn5LcvemmW6woeYjikbRY2Y8ZRcg7slugME88izdhOMOJvh8G5cHJtQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyylLx6/ICyXiz7tYK2kGLjcOTwHEYa6QjNN9xvpTSV0TM8EmkD
	ObQPft6Qvj4Fz5fpX8tWIvRktJYnvwF6traQifnWKTyIP8r54RbBhWz1LtLG717ARgo=
X-Gm-Gg: ASbGncuy24c1Nu7QPbEipAAsMysmxTIK8JabcC7kWKqPwIezbpU1WEP3YEuoKJ25/WG
	pDEahS85a+spWN8fR4lJ+xvmp5toQchE4G3oeS1Bm6l+jiQGDzcvhSIHpiZbJvFgbT+3ZlmZedc
	5HcEGyNF8WJom2Qi1JSJnPG5YhpwfdxDgHLQn17xZQEKgrJnsdkx/O2P1HvqbwXuojnbaXIpDlU
	LvH7ZDxCoyD2yhphUSTkrjLr32OokiOxw3hVXhepTmr2ng/XQMZknblh8Tek4+cMDBwNMN8QOJz
	xeI2nX9ed+o89Viigrctyift+kBDlj/KihEFRWZ2Dq+UBeAkMEJkGccCDlKyWKMm4bhNWKsM
X-Google-Smtp-Source: AGHT+IHl0m/OZ2YTgjx9CaKgNardws6NVkvU4kTAEKOuts391ldEwKbiR8NDEIfzEyuXJto1DxeWHg==
X-Received: by 2002:a05:6e02:1748:b0:3dc:7df8:c82c with SMTP id e9e14a558f8ab-3dc7df8d014mr126479675ab.7.1747955098357;
        Thu, 22 May 2025 16:04:58 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3dc8b75d09dsm6447005ab.54.2025.05.22.16.04.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 16:04:58 -0700 (PDT)
Message-ID: <e1f8156c-e9f5-493e-b780-1f1e63f22cc7@linuxfoundation.org>
Date: Thu, 22 May 2025 17:04:57 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: Implement powercap_set_enabled()
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>, trenn@suse.com,
 shuah@kernel.org, jwyatt@redhat.com, jkacur@redhat.com,
 linux-pm@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250520094345.97200-1-suchitkarunakaran@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250520094345.97200-1-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/20/25 03:43, Suchit Karunakaran wrote:
> The powercap_set_enabled() function previously returned a dummy value
> and was marked with a TODO comment to implement it. This patch implements the
> function by writing the desired mode (0 or 1) to /sys/class/powercap/intel-rapl/enabled
> 
> Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>

How did you test this patch? Please include the information in
the change log and send v3.

thanks,
-- Shuah

