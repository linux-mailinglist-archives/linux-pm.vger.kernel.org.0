Return-Path: <linux-pm+bounces-11693-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AECF941F47
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 20:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCB3D1C22DBD
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 18:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D4518A6CE;
	Tue, 30 Jul 2024 18:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="bhx+qYuv"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48CE18A6C7;
	Tue, 30 Jul 2024 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722363129; cv=none; b=Tb1QC3SzKbUhkFL7GD0MzxNuGC/FWSrn0PPhwBRqjiF4oxnd80mzrXkvGeuPJarz6SdUjjQgz3OH4yArw/kPRxrEjutSz+0AQfjKRmN0OyMKrZ50OLDZDclRIzldJu/q9fivsDL+oTHY9BjLj/RdqrxuxYYHkfIG+V1vQTab+nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722363129; c=relaxed/simple;
	bh=VWN1tIXLNda64hbVwWCXnMXbhG116dkLDNVeCqm+PSk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NySt+rRLhX+mv+qpsM+PqJseQCLASmcFIiJ+G+/K02zGRMwJoYdcOzw+7xOgCR7kF5bijT7wXQvC2l2OjbM7ehbtJzFduDptsL6MDFt0jhtsUFRyuKCEMn2vv3IUlbmjQeLgjSVQTvqnZtlX9J0+beIDQqAJYKtBSkPdsGw46AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=bhx+qYuv; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id YpeWs2SrGVHKTYpeWssKuf; Tue, 30 Jul 2024 18:24:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722356692;
	bh=/UuxgnKYhFfTRoiZZZUFb1OSY49shSXv/0adgAuChfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=bhx+qYuvMyayPX3PzsdM/kwX04bNqKDwbC3KI6dvg0YaaxlkB25kQmOaWMbQIx0qp
	 P9MwwqXQ6TkMi2qR4rtR5yWa6enlRD8X1bESm4va59k5gcZdFTN/EeUVd7aHio9U2L
	 k2yjvnf+BAFr17HWM55dcayChqb7nsMake4fmlTjLkvdgavTKXTjspgGJynfQmCzMU
	 uqgPyTW9ciO42Fnnq1h3vrFd4CIKhFFePx6thFyiWqeKNuNXhCqJLtT5O9hfkvhIsK
	 q4pRc5+ntuciwF93wlMSFpwgsBmyj8AsZeLlrX6mgKUR8wpdz6lK5ciNb2ZMwOICeo
	 YmRhgkR611fKw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 30 Jul 2024 18:24:52 +0200
X-ME-IP: 90.11.132.44
Message-ID: <7ed56f10-99f9-41b9-9d82-45797914f3d1@wanadoo.fr>
Date: Tue, 30 Jul 2024 18:24:44 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH 2/2] PM: Use sysfs_emit() and sysfs_emit_at() in
 "show" functions
To: Xueqin Luo <luoxueqin@kylinos.cn>, rafael@kernel.org, pavel@ucw.cz,
 len.brown@intel.com
Cc: linux-pm@vger.kernel.org, xiongxin@kylinos.cn,
 linux-kernel@vger.kernel.org
References: <20240730065454.2096296-1-luoxueqin@kylinos.cn>
 <20240730065454.2096296-3-luoxueqin@kylinos.cn>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240730065454.2096296-3-luoxueqin@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 30/07/2024 à 08:54, Xueqin Luo a écrit :
> As Documentation/filesystems/sysfs.rst suggested,
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> No functional change intended.
> 
> Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
> ---

Hi,

> @@ -149,17 +149,17 @@ static ssize_t mem_sleep_show(struct kobject *kobj, struct kobj_attribute *attr,
>   			const char *label = mem_sleep_states[i];
>   
>   			if (mem_sleep_current == i)
> -				s += sprintf(s, "[%s] ", label);
> +				sz += sysfs_emit_at(buf, sz, "[%s] ", label);
>   			else
> -				s += sprintf(s, "%s ", label);
> +				sz += sysfs_emit_at(buf, sz, "%s ", label);
>   		}
>   	}
>   
>   	/* Convert the last space to a newline if needed. */
> -	if (s != buf)
> -		*(s-1) = '\n';

The goal here is to remove the trailing space. So you slightly change 
the behavior.
Not sure if it matters or not (this was not done in disk_show() in patch 
1/2).

Maybe an (ugly)
	if (sz)
		sz += sysfs_emit_at(buf, sz - 1, "\n");

or something like:
	if (sz) {
		sz--;
		sz += sysfs_emit_at(buf, sz, "\n");
	}

> +	if (sz)
> +		sz += sysfs_emit_at(buf, sz, "\n");
>   
> -	return (s - buf);
> +	return sz;
>   }
>   
>   static suspend_state_t decode_suspend_state(const char *buf, size_t n)

...

> @@ -257,22 +257,22 @@ static const char * const pm_tests[__TEST_AFTER_LAST] = {
>   static ssize_t pm_test_show(struct kobject *kobj, struct kobj_attribute *attr,
>   				char *buf)
>   {
> -	char *s = buf;
>   	int level;
> +	size_t sz = 0;
>   
>   	for (level = TEST_FIRST; level <= TEST_MAX; level++)
>   		if (pm_tests[level]) {
>   			if (level == pm_test_level)
> -				s += sprintf(s, "[%s] ", pm_tests[level]);
> +				sz += sysfs_emit_at(buf, sz, "[%s] ", pm_tests[level]);
>   			else
> -				s += sprintf(s, "%s ", pm_tests[level]);
> +				sz += sysfs_emit_at(buf, sz, "%s ", pm_tests[level]);
>   		}
>   
> -	if (s != buf)
> +	if (sz)
>   		/* convert the last space to a newline */
> -		*(s-1) = '\n';
> +		sz += sysfs_emit_at(buf, sz, "\n");

Same here.

>   
> -	return (s - buf);
> +	return sz;
>   }
>   
>   static ssize_t pm_test_store(struct kobject *kobj, struct kobj_attribute *attr,
> @@ -390,7 +390,7 @@ static const char * const suspend_step_names[] = {
>   static ssize_t _name##_show(struct kobject *kobj,		\
>   		struct kobj_attribute *attr, char *buf)		\
>   {								\
> -	return sprintf(buf, format_str, suspend_stats._name);	\
> +	return sysfs_emit(buf, format_str, suspend_stats._name);	\

Maybe 1 tab should be removed?

>   }								\
>   static struct kobj_attribute _name = __ATTR_RO(_name)
>   

...

> @@ -668,21 +668,21 @@ struct kobject *power_kobj;
>   static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
>   			  char *buf)
>   {
> -	char *s = buf;
> +	ssize_t sz = 0;
>   #ifdef CONFIG_SUSPEND
>   	suspend_state_t i;
>   
>   	for (i = PM_SUSPEND_MIN; i < PM_SUSPEND_MAX; i++)
>   		if (pm_states[i])
> -			s += sprintf(s,"%s ", pm_states[i]);
> +			sz += sysfs_emit_at(buf, sz, "%s ", pm_states[i]);
>   
>   #endif
>   	if (hibernation_available())
> -		s += sprintf(s, "disk ");
> -	if (s != buf)
> +		sz += sysfs_emit_at(buf, sz, "disk ");
> +	if (sz)
>   		/* convert the last space to a newline */
> -		*(s-1) = '\n';
> -	return (s - buf);
> +		sz += sysfs_emit_at(buf, sz, "\n");

Same here

> +	return sz;
>   }
>   
>   static suspend_state_t decode_state(const char *buf, size_t n)

...

CJ



