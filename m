Return-Path: <linux-pm+bounces-8680-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249668FDF62
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 09:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF6082845B9
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 07:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1C23BB59;
	Thu,  6 Jun 2024 07:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OQ6+R7QI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75801E51D
	for <linux-pm@vger.kernel.org>; Thu,  6 Jun 2024 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658169; cv=none; b=i2Z8VFp94rYg7rn/AMCimENw6fM0tYMkgcsT2BQh5jqG1HXiwmp6SFlF4H46iHmsMPj65V5eKUlDYmz0t1vB+CRngs2Fx/hWVYXVjXRQM1tv1Pd8pLxAtGMCkk422hhW7VqpgS6csjRnnm5jfEkfQyeaPx82nZoAfQnHD9RwTlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658169; c=relaxed/simple;
	bh=eFDNFT2LzXL+6EYWC4FzWMcfFmvhm9QAzRQXNzYRHfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXUdz4a/+AwVCWFb2V1u2S8ZBgbiU1X2l3p7bjiidslum7ciPPPDrlLNmPxmEIt09oXJvzKNw+WU0jjrOlTiCuFE5Kp/PvY6mZ+tfs3hoNdVXWD1XAOLyu5Kk2vqHIqDTs/odEzZfSDJqxKoFkMh1MRgfM1FGbqdwU+lxP6V9As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OQ6+R7QI; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70244776719so472124b3a.2
        for <linux-pm@vger.kernel.org>; Thu, 06 Jun 2024 00:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717658167; x=1718262967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SYc/1A16Jad9UQTX5RKOYTjLS1DJZMAchEeOfZtN35M=;
        b=OQ6+R7QIuHaMCtnYH8g+J+BXoAHS8V/vcrFnps+uCPPdBvZ0mI0ESkaDQXmremuMbj
         W2lxSZsHBHd0j7qYkyimOua58ZiZNZH4T4AX28kPM/M3qFi9J4Eii3fFeq9UpwBHUCyh
         HYH3ZL7AZSaE9FRWJO9ZIIl2IzvnGharlSmp+03LDPnzmn1ERK/UcdlwUdIZUe4HtlGY
         IHrCxcOSpzSVod5V47PLM+7OwlHXt2HZ/fKfrn027A8t4mUIvt14u7KCemiVJI8RPCGN
         +F6PLQcu/0HwxRx0vQgiqg4S9d4zgKs1oz9aYKV/x3tleL0G+u1AmwK7qTM/NgCtMy4w
         ecmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717658167; x=1718262967;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYc/1A16Jad9UQTX5RKOYTjLS1DJZMAchEeOfZtN35M=;
        b=xUVPYEnwcjzy+eS1nhd3BaIrwHigqKFE5DeqXBn/sJJRLDrqKUbc8AZkc+3tR0f91Y
         QGNRLhXKzXHVJQly1Ay3A9rpFxcaymGH6X+mcOB+/Y2u5+mg2eTa/wYBdE3Lsa4bgbsE
         Iz4HpaCVImWyz9v29DkmYocCQcT688+W+LUpunGL0DuaUjS9uuQLxmsec1pAFD4EUORP
         OqwWPNs4rPKM5XswG2JVwDjHpXxABBfzsbx/GyVzG0/C+3Bw4mDkFoDhCzua0ZV5idco
         B3MVhCLodCds48LLlW2Y8Ba/jA5dWl8QlhkQ1Eq0iFWEBVsVpPnjiry4L3lSApcI7WEj
         o8hg==
X-Forwarded-Encrypted: i=1; AJvYcCWdHmEKFwt2KMltxtgEYy35zipTYBEpKI+cSVARezfsjHC0TJFuHKpvyQAfTJRIv6TCOIQucqwshztqxz6o5kBrlnpMsyx+CjU=
X-Gm-Message-State: AOJu0YwnyDbyKyKox9+962vg6vYXLbcrSoGLgfO7YH8327lzbq4XHNgE
	mvaqvYT/kfEkgqYdGJUWgjCZoIKOokDdqp2Uv9yMt+U4gvPlbyvprGuUSFD2+b8=
X-Google-Smtp-Source: AGHT+IG8wBNg0VIBVgAKGvbDu0gp72KpUDbk+8y91N7C4jLon0RKfO0e4pKmjH9j/pWcm7lIXHuJZw==
X-Received: by 2002:a05:6a21:196:b0:1aa:5ca9:c565 with SMTP id adf61e73a8af0-1b2b6e4aab4mr5536085637.8.1717658166805;
        Thu, 06 Jun 2024 00:16:06 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd52b794sm543210b3a.209.2024.06.06.00.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 00:16:06 -0700 (PDT)
Date: Thu, 6 Jun 2024 12:46:04 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "liwei (JK)" <liwei728@huawei.com>
Cc: Ionela Voinescu <ionela.voinescu@arm.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	rafael@kernel.org, al.stone@linaro.org, ashwin.chaugule@linaro.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	liwei391@huawei.com, liaoyu15@huawei.com
Subject: Re: [PATCH] cpufreq/cppc: changing highest_perf to nominal_perf in
 cppc_cpufreq_cpu_init()
Message-ID: <20240606071604.vvthjmhdvd2rwhft@vireshk-i7>
References: <20240428092852.1588188-1-liwei728@huawei.com>
 <20240429104945.esdukn6ayudgyumc@vireshk-i7>
 <ZjoBrF4bAK5ukm7H@arm.com>
 <be312b75-eede-44f5-b7f3-b50f50c6fb56@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be312b75-eede-44f5-b7f3-b50f50c6fb56@huawei.com>

On 10-05-24, 11:06, liwei (JK) wrote:
> In the above function calling process, the frequency is obtained twice. The
> first time is in cpufreq_online(), and the second time is in
> cpufreq_verify_current_freq().
> 
> When the frequency configuration takes effect slowly, the kernel cannot
> sense when the frequency configuration takes effect.

Who is making this frequency change. I am not sure I understand how is
that taking place slowly.

> It may take effect
> before the frequency is read twice, between the frequencies read twice, or
> after the frequency is read twice.
> 
> |------------------|--------------------|---------------------|
> set highest_freq  get()               get()                target()
> 
> If it takes effect before two read operations, there will be no problem.
> 
> If it takes effect between two read operations, policy->cur will be updated
> in cpufreq_verify_current_freq(), the execution path is as follows:
> new_freq = cpufreq_driver->get() //  new_freq = turbo_freq
> 	if (policy->cur != new_freq)
> 		cpufreq_out_of_sync(policy, new_freq)
> 			...
> 			policy->cur = new_freq // cur = turbo_freq
> ...
> __cpufreq_driver_target(policy->max)
> 	cppc_set_perf(target) // policy->cur!=target
> 
> Reconfigure frequency to policy->max.
> 
> If policy->cur is not set to turbo_freq after two read operations,
> policy->cur will not be updated in cpufreq_verify_current_freq(), the
> execution path is as follows:
> new_freq = cpufreq_driver->get() //  new_freq == policy->cur
> 	if (policy->cur != new_freq)
> ...
> __cpufreq_driver_target(policy->max)
> 	ret // policy->cur==target
> 
> Configured frequency will remain at turbo-freq.
> 
> When reading scaling_cur_freq, the frequency value that may be read is
> policy->cur. If arch does not implement arch_freq_get_on_cpu(), and the
> registered cpufreq_driver does not define setpolicy()/get(), the frequency
> will not be obtained through the get() and will directly feed back
> policy->cur. If the above problem occurs, no exception will be detected when
> reading scaling_cur_freq. But reading cpuinfo_cur_freq will reacquire the
> frequency through the get() interface and feedback the newly acquired
> frequency value.

-- 
viresh

