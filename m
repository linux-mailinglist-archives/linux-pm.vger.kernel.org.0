Return-Path: <linux-pm+bounces-26598-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B7DAA7A6F
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 21:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD2A1C00F70
	for <lists+linux-pm@lfdr.de>; Fri,  2 May 2025 19:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5C71F3BA4;
	Fri,  2 May 2025 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XfZ+AO1f"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0102A1F1301
	for <linux-pm@vger.kernel.org>; Fri,  2 May 2025 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746215780; cv=none; b=MKsYyrEzIKfvAVrPKJ1Lc7Ia3KD4YEPnPkzlW+/0cZwzbCzI+fuxcSAL+Wj6tBlzCOo+THkf2v3mV9N37kW9rnI080/0AGLOypDHKgf1/DKCqL183l0yjIAFbTdCp3Qjv6uRB4MQO8nxQBX3Q41Nzv1deGGDkSX8LC6iynX3jX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746215780; c=relaxed/simple;
	bh=xlSMk+igEoGqHGelwCpnP9t9X+QTloJPu6JprECcilw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aNopRaI166jRomlWQFkogxCLvrArORIXiRtOpYB6V9R90vuKRT1E3QzMjkWcOtY8Ad0irkUXeFjxaMFk1IbG++l8gh0cLUW9U1brTRielHoWrHNDqgWglR+yiU2ChcBa6j28jgWpUf30a/kikvHtHI1weQNbyhLHzoSK2bP9CAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XfZ+AO1f; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-86142446f3fso69480639f.2
        for <linux-pm@vger.kernel.org>; Fri, 02 May 2025 12:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1746215777; x=1746820577; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jdhliYzbvYtKg2qoeYrELdpCfzAzWomz8eFEQHj8K7c=;
        b=XfZ+AO1f4ez6ALp8GcTgAiaIc1H9vFsjs751wMwfg6RX/2EWpmcJ7YWLa8DkAXaPcD
         SJ64j25HiASZQdRC5qDCY3ENNC+Pq5YkZO40GS5DnC3XSMQXSpvkqonnznKXHQLSQU/z
         SXp/2ejL0b9GCXsjC1WS5JkCxTkKJ4/2KhnJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746215777; x=1746820577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdhliYzbvYtKg2qoeYrELdpCfzAzWomz8eFEQHj8K7c=;
        b=wxaGVO3SZeiTwd2Xy8QeTeE0g9hd0puj02bnP7N2uXWU63DA2Ji7aTT/xpJQULKuBf
         v1olf6ohS9YOqPN2oLH+8sgaoSygrJtIzrpi2Z6DiNyuNFLfti2tSedQt8eQGyxq8eeb
         VlfmGtpizzbINdfM4D7CWdJQunnyx9b8sxt454h005Q0MPAviZzoCMgC3Rb0AlNe+rlb
         Tn+rFgVfl8x+01Io3YMF0530bnofN+L/fQlkLnzZHSvrwwQ4cuMvfGaV9jBYg+PV3wQd
         WyT8yjzh5uXPz3Tb/cIfE5zaxQ0ETgTZMU5Pa4Dq3l93cmNIqT9zqKg98x2pmE4VjoCv
         HSQA==
X-Gm-Message-State: AOJu0YwpiyNvg3f1DpqCu5DVfSvk/PeOmHC54SRCjd7oPL4QUmkSm1VB
	V1cXDHns/DMkYzA9S5it7m7IZjMWI+D/ah5wUG78CPIKtfD+GCxoAoKx3ZrziAc=
X-Gm-Gg: ASbGnctQ9mwvmMIeWRTXqDWk0VhS/mRtYTWXcpQPqjlG5VJZRi8RQKNSASb5V8keSgN
	2puZk9jMk8E83qJgU4eNhd+xiNRC36u9ZdtdF9PtObwjE5AFdLdvD9N+NT8DvI5okcZoGgVB6+2
	WkpbxfSz38SGZOJArlkNpL5O49GrZMzD8k9qSAORIrgVb14hw9TMHi9MjgXRFCMdBYAIZEHVu20
	/Amccp0nn/pc9hEvsQGZrU7eSS/7yAXy8tvqZIXsYmBInHvWmQ7wcna2+y4npi9tmiWk4EIwy71
	i6LpvWL4QKLwnfDabJZsqNIqSuK5k5FFfrkVX+y352H0rZymYrg=
X-Google-Smtp-Source: AGHT+IEXHipGEkbZab0i8/+Zk388KeIbvolMM/RcaYRIZEy+vdl66HVXkkYvwY1yLUPCONHL39+beA==
X-Received: by 2002:a05:6602:3a15:b0:85e:1879:c708 with SMTP id ca18e2360f4ac-8669fb07f5emr529485439f.1.1746215777004;
        Fri, 02 May 2025 12:56:17 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88a8c8cdesm540615173.17.2025.05.02.12.56.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 12:56:16 -0700 (PDT)
Message-ID: <91e934ef-5bb5-4e67-b6dd-7f0308d4ee49@linuxfoundation.org>
Date: Fri, 2 May 2025 13:56:15 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: change binding's makefile to use -lcpupower
To: "John B. Wyatt IV" <jwyatt@redhat.com>, Thomas Renninger <trenn@suse.com>
Cc: linux-pm@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org,
 John Kacur <jkacur@redhat.com>, "John B. Wyatt IV"
 <sageofredondo@gmail.com>, Wander Lairson Costa <wander@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250429204711.127274-1-jwyatt@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250429204711.127274-1-jwyatt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/25 14:47, John B. Wyatt IV wrote:
> Originally I believed I needed the .o files to make the bindings. The
> linking failed due to a missing .so link in Fedora or by using make
> install-lib from the cpupower directory. Amend the makefile and the
> README.
> 
> Big thanks to Wander Lairson Costa <wander@redhat.com> for the help.
> 
> Signed-off-by: "John B. Wyatt IV" <jwyatt@redhat.com>
> Signed-off-by: "John B. Wyatt IV" <sageofredondo@gmail.com>
> ---
>   tools/power/cpupower/bindings/python/Makefile |  8 +++-----
>   tools/power/cpupower/bindings/python/README   | 13 ++++++++-----
>   2 files changed, 11 insertions(+), 10 deletions(-)

Applied now for Linux 6.16-rc1 - will be included in pull request to
PM maintainer.

https://web.git.kernel.org/pub/scm/linux/kernel/git/shuah/linux.git/log/?h=cpupower

thanks,
-- Shuah

