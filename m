Return-Path: <linux-pm+bounces-35421-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0B4BA1582
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 22:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67BCA7AB2D3
	for <lists+linux-pm@lfdr.de>; Thu, 25 Sep 2025 20:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FC728CF66;
	Thu, 25 Sep 2025 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gwMCjOAv"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141171114
	for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 20:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758831736; cv=none; b=PIao876OBlkw+YvjJ20yrKMTCGF35MKwAlf+LWXywOEtY3BHyF6qmmHxSSC4Y2zX2lcCU0hJAW8xRcwJjSHd/sQ4lJjI8BvomxCKSQ6cbORuSwZ7jzIzVD0DA1l9K9cVhjyWzmqOt8IGfUcQC4zXxFh+wGBMzCoMXJpWRRUfyfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758831736; c=relaxed/simple;
	bh=bxSjAxidNxVABYIQRLp2pZgJa2CKnzcfpocYnsNExjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YelOvOj5bzZY3wdweKsweLg0KpOJ3wYCrmtgJu79E4ehfTcxLcg/BDYD9iEE+hDLlz6df17sIIKSn7uBxtBL6Q1rSDYmBoRG/n01+QSPfYY1zgC8cHWsJ3/nhB1IuuwJIJGX+bM3WXnoiHm2jaZDK76WCXrFmgwnrVcZCRT06gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gwMCjOAv; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7459d088020so801747a34.3
        for <linux-pm@vger.kernel.org>; Thu, 25 Sep 2025 13:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1758831732; x=1759436532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4ts4LKbkSbJZr/uD+67nnFgKr98M2rajWsp1ooXb77g=;
        b=gwMCjOAv5zRxnxKJ4eEwW6iNwb/Q7NoJLalMd17OqUZJSoIlELVD/z2T9DoID0U1Yr
         79sK6zAAe9kmF2btK9R+23XHD0B5G8JSmA/7Ra/hLDDQPR+zFEl2wvMy+7N4JW3BXdln
         MkgHLcd/vm4XMhUpX3poeBhBKHwYIt/kNCRR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758831732; x=1759436532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4ts4LKbkSbJZr/uD+67nnFgKr98M2rajWsp1ooXb77g=;
        b=geBe5AMNmvS2V2S7xzNtdlhJByBULzwNc+A2dW19hWZ2zucFTuCWU6fkWH+cCOtTPf
         sma1ccoTg7/RUSUd52vE4u1IapgQA3YGBAab/0fl7dgX/xGBvG1T8HZe14mWSp+mWKmw
         jFAKLgEg5yvV2PHrdh4bUXTcwGrBEE0jCYSr3OoFx2VQfZAeuGbCP/57871ubdGxptjO
         ja2j+i5ICCJ/niCCI7kf22uICaKE3/lVVskZA9sVC3xr9XnYK5ukRtPdB9TeE0PUmVJv
         1lBavdVLQ7N0lxYUwdiLH2OPPeS62zQozHvuewTy2B4b3zJW6fZSjjWfPs22VRnltu2G
         SN1Q==
X-Gm-Message-State: AOJu0Yw8MI3KCDbMCnJTXaPEWhXlFe2i1osxNvHt4tYoM22HbkBKv01I
	e/SH9kkNWXC0MI5rwHnuaPq5c1z5m/JR863cHA1K5Tfoq2lbQdZCn7ebEnih3s6IkrY=
X-Gm-Gg: ASbGnctyZ7fOZSiBsoRDMb9XviGqvAWj6y9TPXzKeHdvrbPUoH+FlKY++7ynhwAG2Ps
	ed6clv3jckx6Lck1e/61ZSaCqcLdsxoAdcvoPqTorZqDsvW/VYTOHYq/5w9BSu4FRlBy2lkt4RY
	hg73OUBmYLGeaEjU0Ls5/FfMN2MmYoIeW6O06DqJGbxczVsb9w3TcEsxfvvVb4pxsYOrZEeTG/g
	G2qwFIWoaHlWEWdoASMFmoKuBIT5sK1ltwXlxZhUJnG4Nrn5ohZHZh5jji62yF8O/i92STY9fne
	G43N5BnSbfB7ycIUAPZXN7SM3rtKBejGfKvxLvhdnAV/jLPCl4fSjxopGLxMDieQEetNk5GfIPo
	mR5uF8i9y/zVXPg8UItSZPkkPk0j3mFdjnQg=
X-Google-Smtp-Source: AGHT+IFulE+wydSPUdndhxSww98ghRsjiXzaEg9fXECYmii1fqhDsAS31oaYlKbOF394uiz4oMhMxA==
X-Received: by 2002:a05:6808:228a:b0:438:386c:5f0a with SMTP id 5614622812f47-43f4cf216d8mr2048189b6e.48.1758831732087;
        Thu, 25 Sep 2025 13:22:12 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43f512145e7sm518650b6e.19.2025.09.25.13.22.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 13:22:11 -0700 (PDT)
Message-ID: <a866de67-8ab2-4913-b601-7e2049ce258f@linuxfoundation.org>
Date: Thu, 25 Sep 2025 14:22:10 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools/cpupower: Fix incorrect size in
 cpuidle_state_disable()
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, shuah@kernel.org,
 trenn@suse.com, jwyatt@redhat.com
Cc: linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20250917050820.1785377-1-kaushlendra.kumar@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250917050820.1785377-1-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/25 23:08, Kaushlendra Kumar wrote:
> Fix incorrect size parameter passed to cpuidle_state_write_file() in
> cpuidle_state_disable().
> 
> The function was incorrectly using sizeof(disable) which returns the
> size of the unsigned int variable (4 bytes) instead of the actual
> length of the string stored in the 'value' buffer.
> 
> Since 'value' is populated with snprintf() to contain the string
> representation of the disable value, we should use the length
> returned by snprintf() to get the correct string length for
> writing to the sysfs file.
> 
> This ensures the correct number of bytes is written to the cpuidle
> state disable file in sysfs.
> 
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
> Changes in v2:
> - Use snprintf() return value instead of strlen() for better efficiency
> 

Thank you. Applied to git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower
for next PR to PM maintainer.

thanks,
-- Shuah

