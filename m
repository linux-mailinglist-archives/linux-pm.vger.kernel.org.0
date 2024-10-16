Return-Path: <linux-pm+bounces-15796-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA119A1365
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 22:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08C581C21396
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2024 20:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68D2215F6E;
	Wed, 16 Oct 2024 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yu+vYDUI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3367C1C4A14
	for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2024 20:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109134; cv=none; b=eTlKsE41lp0pRJI7GeqssTQ/pKMNyUP/NFPUnGBEXMn9BG+bKToeXQkS0Xhpfzto/Cx0aOC35jDRjs6wWWYSPpfm+KSV5d7+owvJ2YR7X5FfY9CqNRLzV3Uas/Xm/+ATji46YCLqiavNt9mpN0PB/XN0ZursHPK3XCkpUt6bOPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109134; c=relaxed/simple;
	bh=4C7oXOdGrYe+yW7Ps83eKYymTHybLV2V5p20sTO2t7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r35vSP9C/Yz+Vg+TCk/nO3Wu3Hn8rcescOOQ1Yk9ZDxn90M69HAQcMGIi0P5w5ppBo9RzDIID0/FReuhXiXNXbewGNxq4FnJgMzJEzi1iSPtOiocJZ0DxyKfOVhLliu0X7lxCbKUVoCc7P7VitgLZE9Cv1xjxbhYmG9eVlVctmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yu+vYDUI; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a3aeb19ea2so1331805ab.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Oct 2024 13:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1729109132; x=1729713932; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uq5bLD186tETtBZNYY76DXajC76NELDYBxIFyygj6ek=;
        b=Yu+vYDUIongb6VCWjRCZySChiwcw63slkTrSTcw25F2a5Qo9Hr41UdboCNZK+rmQSr
         1f8yZE6Ub9G2r5A1IRLZYdBMxM9L1tcsLc9aV83LRut8T8hi5LNOaMMlwjNyVfRsy2M7
         Qa4t0WjO63x8pMJeoDWge+vB185b8ubJB5NH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729109132; x=1729713932;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uq5bLD186tETtBZNYY76DXajC76NELDYBxIFyygj6ek=;
        b=EisAo0hZ08Yl9rreU3tNfm7AXRSEq9DxpV+FHfKHEP1/TrUJOQ+zIE0uwCEAE8kVYE
         WeEP3cXYOWNVSy7umrus37W+3Wa1QAK/Gi91ZrL8YU/xdwSXHD4OFgxJ+MZ6mlKnlirR
         Tnuouk3HIjX6dy6ZjOU0DYafYV4uaEKzsp6u/pPmh9Q+DPwZYKXw0cpiZ9soibay2H0h
         IvSS98BmYfeRtu1rREhYS+2z7xdf8uzYTOJyRwJIlIfPWjmLhdERsRuv8W5XOek5J2O5
         AltaSfNfmq9g16ap5bq58YwWqtQMUeI7u+H13OmRPyaFktyBbG9e/mKtm/NcHkSjlJe2
         11Ww==
X-Gm-Message-State: AOJu0YwlbdLvsPAlVrIcJ+4fvx5ZkXBmQ2pYIA9/3wMiuRAy0yNjG8xn
	iWmTYaeK/xThBej7we2fCIZYZ6LlK448DJFdq3JKPfjd/9hDR1mjNXTlZ9Axeps=
X-Google-Smtp-Source: AGHT+IFyrvP7WlAESEzcHpU4lGmOucghLrlftqIdvWhK5bg2twkKKzE7vsK13Hgqb6Ooq9Tj/cJchA==
X-Received: by 2002:a05:6e02:3b06:b0:3a3:be8a:8717 with SMTP id e9e14a558f8ab-3a3dc4d5afbmr53132945ab.15.1729109132264;
        Wed, 16 Oct 2024 13:05:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbec9e1827sm980368173.77.2024.10.16.13.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 13:05:31 -0700 (PDT)
Message-ID: <9533062f-d0a1-44f0-940f-279fadc9c3d3@linuxfoundation.org>
Date: Wed, 16 Oct 2024 14:05:31 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cpupower: Add Chinese Simplified translation
To: Kieran Moy <kfatyuip@gmail.com>, shuah@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 ccheng@linuxfoundation.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20241015185348.8306-1-kfatyuip@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241015185348.8306-1-kfatyuip@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 12:53, Kieran Moy wrote:
> Sorry for the oversight, thanks for your help!
> 
> Signed-off-by: Kieran Moy <kfatyuip@gmail.com>
> ---
>   tools/power/cpupower/Makefile    |   2 +-
>   tools/power/cpupower/po/zh_CN.po | 942 +++++++++++++++++++++++++++++++
>   2 files changed, 943 insertions(+), 1 deletion(-)
>   create mode 100644 tools/power/cpupower/po/zh_CN.po
> 

Thank you. Applied for Linux 6.13-rc1 to branch:

https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/?h=cpupower

thanks,
-- Shuah




