Return-Path: <linux-pm+bounces-42014-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UPLtLhSDgmkyVwMAu9opvQ
	(envelope-from <linux-pm+bounces-42014-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 00:21:56 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDAADFB46
	for <lists+linux-pm@lfdr.de>; Wed, 04 Feb 2026 00:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5014E30D308A
	for <lists+linux-pm@lfdr.de>; Tue,  3 Feb 2026 23:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27783191D4;
	Tue,  3 Feb 2026 23:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gMSMm8Xl"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD57E792
	for <linux-pm@vger.kernel.org>; Tue,  3 Feb 2026 23:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160801; cv=none; b=oK/V5kW+phfjVV0xMj1z+p3/qGee7Fxf3txkVjBrHca6rTJCCeXiQF7HadbysaTZn4hRcoTw1EX53SG7hF11JdvsY/RPC2ot+efnknLrhYKcG/injnJlS/dnJbhKohl8Jx4IxZjK9ewRJ9kS8PpY2+UEZtD0/LUunVtwIOmyKEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160801; c=relaxed/simple;
	bh=G81U0UDHby4RrLSchNdEF9/UbbKHjneIt8BYzC8lVwE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=X4qOZQruGUf4U63Od6WagyDCzAnw0xH1JFyqfmKqFJjv+hZLQsvAJWy4fel/lWtzU5sZ1lSDALAl+HMPtNgUnbQ5/DxPZDEsVmomzqW5LP8Uo9e+slRCYCl1/eH1D+ifkUqEVEgU6o3T7dz5YEy+XMFFtz2ttvcuTXT9oap/3Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gMSMm8Xl; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c54f700b5b1so3950869a12.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Feb 2026 15:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1770160799; x=1770765599; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jm9DxbIWuku09f2xOOYS1JETDqxEFrbJpaIM7ZnpNuQ=;
        b=gMSMm8XlJisiE4sMaLxNss5ense9pzIpKEDgT88qjSqzZd7jnEvACvbHEcBHnMl6WK
         RMfaeWCOnWYhsW/kRerPlcPK5HUUFt/s7XVInX8h5z53Ji31PnLHK9x2D6NMJKlEylCu
         gJ28ZRWyc+BlFE+9QYVxKte1ZX+Br/Jukf6yVT3GVMMa7C6KpvOx2wvoVDh2ciyVTg+U
         M1MVCjwOIprtfKspSLm6nUDqgiQLlydQfidiA6HXDA3Vb3iGgr0ebT2eGupSXIhoewbn
         /dsLyiGsIN5pDyRII/DstcrD7Epstd7kBCTHAkHfQmTzQYQrRXigtYAr0ddYAttXuvcw
         eh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770160799; x=1770765599;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jm9DxbIWuku09f2xOOYS1JETDqxEFrbJpaIM7ZnpNuQ=;
        b=hlZQp5GAEMLwbA/vNGH+B+juMqW4REvLrc5KGd8ZK8R9T6Cmi/ZfprRsD0TiygA2Kx
         uKWwZxfz3YCi4WOj12syACKcm/mr1hUNlcI8VF8ak6Z0wk58GgyMPRR8ckcfOEQ8VsTB
         lj1/H0ezEXAO65sarzIF5iuOZfJucNo4bNVBP8uNhrYt37qeE3f/knkxmc2BchWj5vmc
         ZW6VVBDOSD2d6U/NnCZ2z5yyJvDu6ofZJJC0kvjdi/aCIXesoIzRwEULi3ZZjDT2G3vn
         FRulIxgsS/g0hGbYJX9IOqXUW2PymtEEvcIc4Ii6fnmp105jurpROwq1qeiDUt32DCxD
         Rafw==
X-Forwarded-Encrypted: i=1; AJvYcCVu6Fu5RenskeQwRTAAfzxhbPZv7AjVX+Z2qzXvAgml5Z9goTrdwfYN4HNGAGiQEJcd3nl9f1dzQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7bti3Ydk43R3vdEStbtj0TtZsn5G4o8pDeNuTpi7M1isMVYPj
	PO74KqCrP1FSVhW7gWVQd6TaUN3HdnY68wK1ZVBrYjwGjkn0cAysk8ymGodHhmSL/ak=
X-Gm-Gg: AZuq6aJPTq/ERifzURFK0EyMnx2h2pGEQHme97NdBjg+kc2c54hgUP0wGs15EhfsYo5
	rbbNhBKZsRM1sV2kV5a+WzmewNlgFy4U+wdvAb6qtza0B7hRQMvU7GWpYY06gSe03JhZcXsB1dH
	bbH9Y84HD/gW1nmHmqgb1C+Q8iq1blp3J4q0Mit9wimLk4qRrc3GHJou6a6Rso/1/dCt1l4e3vG
	o2jeCNSNJobPWUz0pEeUpuj/BHu+bC+Fs+bSKkDbEyxsfQOeFrL1s7B6y+GVtzwwcWo652loMyB
	3FkaVFDqZFtWBemJ6Rlnf4rOjl7NVvrsUs2oFVMEC9tiJvCI56juAVknKnsKtTvH2D8cl0y5pvL
	FaGUjThOeDA+IvJ50q+TMitBzqF0F8mZFunY+2Y/O9+70C/9yzF3bQTJo8LgY+TgflRWT8tVoKc
	8e+ZQnkyRwa/VtbdNOnNA=
X-Received: by 2002:a05:6a21:618b:b0:393:38a3:8975 with SMTP id adf61e73a8af0-393725d9c10mr968502637.70.1770160798635;
        Tue, 03 Feb 2026 15:19:58 -0800 (PST)
Received: from localhost ([71.212.200.220])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a933851685sm4579565ad.13.2026.02.03.15.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 15:19:58 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
 Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pmdommain: add support system-wide resume latency
 constraints
In-Reply-To: <CAPDyKFpq_mkyGfR-OYwTU3k62fkzXWiz07ZSR5j+FY72vYXxmQ@mail.gmail.com>
References: <20260120-topic-lpm-pmdomain-device-constraints-v1-0-108fc4cfafce@baylibre.com>
 <20260120-topic-lpm-pmdomain-device-constraints-v1-2-108fc4cfafce@baylibre.com>
 <CAPDyKFpq_mkyGfR-OYwTU3k62fkzXWiz07ZSR5j+FY72vYXxmQ@mail.gmail.com>
Date: Tue, 03 Feb 2026 15:19:57 -0800
Message-ID: <7hbji5za76.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-42014-lists,linux-pm=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[khilman@baylibre.com,linux-pm@vger.kernel.org];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-pm];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,baylibre.com:mid,baylibre.com:email,baylibre-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 3FDAADFB46
X-Rspamd-Action: no action

Ulf Hansson <ulf.hansson@linaro.org> writes:

> On Wed, 21 Jan 2026 at 02:54, Kevin Hilman (TI) <khilman@baylibre.com> wrote:
>>
>> In addition to checking for CPU latency constraints when checking if
>> OK to power down a domain, also check for QoS latency constraints in
>> all devices of a domain and use that in determining the final latency
>> constraint to use for the domain.
>>
>> Since cpu_system_power_down_ok() is used for system-wide suspend, the
>> per-device constratints are only relevant if the LATENCY_SYS QoS flag
>> is set.
>>
>> Because this flag implies the latency constraint only applies to
>> system-wide suspend, also check the flag in
>> dev_update_qos_constraint(). If it is set, then the constraint is not
>> relevant for runtime PM decisions.
>>
>> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
>> ---
>>  drivers/pmdomain/governor.c | 42 +++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 41 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
>> index 96737abbb496..03802a859a78 100644
>> --- a/drivers/pmdomain/governor.c
>> +++ b/drivers/pmdomain/governor.c
>> @@ -31,6 +31,8 @@ static int dev_update_qos_constraint(struct device *dev, void *data)
>>                 constraint_ns = td ? td->effective_constraint_ns :
>>                                 PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
>>         } else {
>> +               enum pm_qos_flags_status flag_status;
>> +
>>                 /*
>>                  * The child is not in a domain and there's no info on its
>>                  * suspend/resume latencies, so assume them to be negligible and
>> @@ -38,7 +40,14 @@ static int dev_update_qos_constraint(struct device *dev, void *data)
>>                  * known at this point anyway).
>>                  */
>>                 constraint_ns = dev_pm_qos_read_value(dev, DEV_PM_QOS_RESUME_LATENCY);
>> -               constraint_ns *= NSEC_PER_USEC;
>> +               flag_status = dev_pm_qos_flags(dev, PM_QOS_FLAG_LATENCY_SYS);
>> +               if ((constraint_ns != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) &&
>> +                           (flag_status == PM_QOS_FLAGS_ALL)) {
>> +                       dev_dbg_once(dev, "resume-latency only for system-wide.  Ignoring.\n");
>> +                       constraint_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
>> +               } else {
>> +                       constraint_ns *= NSEC_PER_USEC;
>> +               }
>>         }
>
> dev_update_qos_constraint() is called only to take into account the
> QoS constraints for the device's *children*.
>
> It looks like we should also be checking the PM_QOS_FLAG_LATENCY_SYS
> flag in default_suspend_ok() for the device in question.
>
> That said, there seems to be more places in the kernel where we should
> check the PM_QOS_FLAG_LATENCY_SYS flag, like in cpu_power_down_ok(),
> cpuidle_governor_latency_req(), etc.

OK.  But now that we've agreed to drop the userspace interface for this,
I wonder if the better approach is now to consider the flag to mean that
the latency applies to runtime PM *and* system-wide PM.   Then, without
the flag set, the latency applies *only* to runtime PM.

That approach would allow the current default behavior to stay the same,
and not require adding checks for this flag throughout the runtime code,
and only require checking for the flag in the system-wide PM paths.

>>         if (constraint_ns < *constraint_ns_p)
>> @@ -430,12 +439,43 @@ static bool cpu_system_power_down_ok(struct dev_pm_domain *pd)
>>         s64 constraint_ns = cpu_wakeup_latency_qos_limit() * NSEC_PER_USEC;
>>         struct generic_pm_domain *genpd = pd_to_genpd(pd);
>>         int state_idx = genpd->state_count - 1;
>> +       struct pm_domain_data *pdd;
>> +       s32 min_dev_latency = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
>> +       s64 min_dev_latency_ns = PM_QOS_RESUME_LATENCY_NO_CONSTRAINT_NS;
>> +       struct gpd_link *link;
>>
>>         if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN)) {
>>                 genpd->state_idx = state_idx;
>>                 return true;
>>         }
>>
>> +       list_for_each_entry(link, &genpd->parent_links, parent_node) {
>> +               struct generic_pm_domain *child_pd = link->child;
>> +
>> +               list_for_each_entry(pdd, &child_pd->dev_list, list_node) {
>> +                       enum pm_qos_flags_status flag_status;
>> +                       s32 dev_latency;
>> +
>> +                       dev_latency = dev_pm_qos_read_value(pdd->dev, DEV_PM_QOS_RESUME_LATENCY);
>> +                       flag_status = dev_pm_qos_flags(pdd->dev, PM_QOS_FLAG_LATENCY_SYS);
>> +                       if ((dev_latency != PM_QOS_RESUME_LATENCY_NO_CONSTRAINT) &&
>> +                           (flag_status == PM_QOS_FLAGS_ALL)) {
>> +                               dev_dbg(pdd->dev,
>> +                                       "in domain %s, has QoS system-wide resume latency=%d\n",
>> +                                       child_pd->name, dev_latency);
>> +                               if (dev_latency < min_dev_latency)
>> +                                       min_dev_latency = dev_latency;
>> +                       }
>> +               }
>
> cpu_system_power_down_ok() is at the moment only used for CPU PM
> domains. If the intent is to take into account QoS constraints for
> CPUs, we should check the QoS value for CPU-devices as well (by using
> get_cpu_device(), see cpu_power_down_ok(). For non-CPU devices
> something along the lines of the above makes sense to me.
>
> Although, please note, the above code is just walking through the
> devices in the child-domains, there is nothing checking the devices
> that belong to the current/parent-domain.

Oops, yeah.  Good catch.

> Nor are we taking child-devices into account.

Indeed... double oops.  

This makes me wonder if we have any helpers to iterate over every device
(and children) in a domain (and subdomains.)

Kevin

