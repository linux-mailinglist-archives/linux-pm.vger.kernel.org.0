Return-Path: <linux-pm+bounces-3303-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4673848674
	for <lists+linux-pm@lfdr.de>; Sat,  3 Feb 2024 14:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 030001C22DC6
	for <lists+linux-pm@lfdr.de>; Sat,  3 Feb 2024 13:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DCF5DF2A;
	Sat,  3 Feb 2024 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="rQsgwxIN"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A385D90F
	for <linux-pm@vger.kernel.org>; Sat,  3 Feb 2024 13:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706966133; cv=none; b=eGLmKt50zqqCYCQQywOGVTa0jWyq7+gX2UOsCu9/rtDsZJeUcAyrYhjoGgVh8AZ8pxuIeJyw/iByDeK1mkXqzFdKXqOcgOX8VG/r3+MyAGAwYrWd0BsXz8iLwUCBCDpDRRaqFwsZ06szlK5nKt7N+DPg1uKNyLbB4HSvXm2OHJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706966133; c=relaxed/simple;
	bh=WGVA9p3snKR8ifQ8Y3VDuZRFSJm73lwUChTEJqT7wFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QA2GHizBVHj2ZjY2njxMovxJupzOclRcTmLOpJhcJ1H9eIM1pOUSjPMkGQ2MtnWuxdCUytRnObc0j9qX/07l3ws5qb2vzsas5X6iouUHI/AG7gfwdhva2Szng01QTHghAjP1YBOz4HtTk0aGpy9qErvRhwd2rIAAYQUao1INxDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=rQsgwxIN; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3604697d63so466310166b.3
        for <linux-pm@vger.kernel.org>; Sat, 03 Feb 2024 05:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706966122; x=1707570922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=v8j6WuzPOMN7vKFNBjjvslOLE2u2wOdQ2j4qDDS8cBM=;
        b=rQsgwxINcOcuI82fhH/xG8hkn8AgM0qvA4rrFcDf8pubV+OVdMpC5QUWiDZuvG0Hdp
         ZRsFl7lqpJpD/OFj6QD1BpuFh20cUkOpXuBe9RfD8otX1NWqereOuWlsYJZEDfp4aPzw
         T9EsymTncUGa8O3HYbPHQrJibT+t0BY9vwhUNJBZDY5lWep8cvAVvKcmjzBuDbBem6ll
         5pP7Y+v3hUu3FMVgdSaLyGnefk9ORs8XhiqanWEzbM2A5psBj328ieAMRZk3pi6xb0Xp
         kDy50Lm7Mm+FBq8VEhOpidvB63j1ZZkh2+7OOflY9iPz5IYfhLcXGEonagpV1cdy8+im
         TJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706966122; x=1707570922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v8j6WuzPOMN7vKFNBjjvslOLE2u2wOdQ2j4qDDS8cBM=;
        b=WqJ9FMjLe8gi73K6o5uD6xshHbKZdTgIs7U5b1RdozQTjoXH6rkeEaEcPd13hA7ELA
         2mBk5Y2bq1NxNwrv/vC691HTk613gaKR70LT0Inx01Tykc8vl16D4At0g/GkWT7Fa53D
         q2IQLAcjfOr5r3qFMK9wTXoD466lDVvVihA6XuiKg/i/xsoGHjGCxBW4pzZVODw1mF8B
         qqUcviWoFi0Hnq7n7WqACY6ijTRRcXPLz8GFWDioRO7or7JuqHMJAWr5+DAkX6wAlHJi
         RB+LKPXkmJ2/5CT5hGpqo1sl11yzzR/v9cK3YsSt/FXnTvf6ZyUqaln6xOMnLG65Kk3A
         N+yw==
X-Gm-Message-State: AOJu0YwrSX+Gm5xggEwjg4b372obAVYuB8iUNfT+rMnaJyifUeD8CJq/
	bQRo9iMh5PDSpHY+Dq0r9gpUJB6I2b5JHvLfW57GfZ46BIVsnR6ZXKg/H4Xlyy8=
X-Google-Smtp-Source: AGHT+IGmepwLZ181zchSTo/szSPJm/J9QkPMXlRe5Ipu8n64rC5/cHFbcchBAin7TrGVnbtJ1N4Z4Q==
X-Received: by 2002:a17:906:3091:b0:a37:2738:1eab with SMTP id 17-20020a170906309100b00a3727381eabmr1944640ejv.55.1706966122457;
        Sat, 03 Feb 2024 05:15:22 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW4MWdKP+LwtpimyOlvEufGj2bkCV95lvxE4Edv1JrFZYRzdPNSKF5+2dt5YzZGBIPdtz7J1X9qzfaxdyN+fB3PI/85vu1ZwfV7hgABRPW9MLcvYfimzHIGJ6IK/hlzpfAgKKriOZXB42UsD8oWRQXcZoGJuuKhtqi5Q+Xa6RYvmt8QUWlzJ1zLcgzngt85CIVWv5rMz2ugzgfdSO+aH80OYuAZorpkqEj9HQF306mUzjrdjF87LZUqMHukNyPPaF8bGysN+p7Pfewp/KnQi6shV3Xp2RKROQh9uFulnbQtf8BvNVLNTquTKRL3kgwiZwlpZ4GKeYfYE30ECMqMGS0HEIr5S28G69PzDLMztm0o5wE7STgjHeuVn79sLQAfGWQ=
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906640d00b00a35d7b6cb63sm1964400ejm.28.2024.02.03.05.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 05:15:21 -0800 (PST)
Date: Sat, 3 Feb 2024 14:15:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] thermal: intel: hfi: Enable interface only when
 required
Message-ID: <Zb48Z408e18QgsAr@nanopsycho>
References: <20240131120535.933424-1-stanislaw.gruszka@linux.intel.com>
 <20240131120535.933424-4-stanislaw.gruszka@linux.intel.com>
 <ZbzhuXbuejM1VLE3@nanopsycho>
 <Zbznft0x7DRWjUTQ@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbznft0x7DRWjUTQ@linux.intel.com>

Fri, Feb 02, 2024 at 02:00:46PM CET, stanislaw.gruszka@linux.intel.com wrote:
>On Fri, Feb 02, 2024 at 01:36:09PM +0100, Jiri Pirko wrote:
>> Wed, Jan 31, 2024 at 01:05:35PM CET, stanislaw.gruszka@linux.intel.com wrote:
>> 
>> [...]
>> 
>> 
>> >+static int hfi_netlink_notify(struct notifier_block *nb, unsigned long state,
>> >+			      void *_notify)
>> >+{
>> >+	struct netlink_notify *notify = _notify;
>> >+	struct hfi_instance *hfi_instance;
>> >+	smp_call_func_t func;
>> >+	unsigned int cpu;
>> >+	int i;
>> >+
>> >+	if (notify->protocol != NETLINK_GENERIC)
>> >+		return NOTIFY_DONE;
>> >+
>> >+	switch (state) {
>> >+	case NETLINK_CHANGE:
>> >+	case NETLINK_URELEASE:
>> >+		mutex_lock(&hfi_instance_lock);
>> >+
>> 
>> What's stopping other thread from mangling the listeners here?
>
>Nothing. But if the listeners will be changed, we will get next notify.
>Serialization by the mutex is needed to assure that the last setting will win,
>so we do not end with HFI disabled when there are listeners or vice versa.

Okay. Care to put a note somewhere?

>
>> >+		if (thermal_group_has_listeners(THERMAL_GENL_EVENT_GROUP))
>> >+			func = hfi_do_enable;
>> >+		else
>> >+			func = hfi_do_disable;
>> >+
>> >+		for (i = 0; i < max_hfi_instances; i++) {
>> >+			hfi_instance = &hfi_instances[i];
>> >+			if (cpumask_empty(hfi_instance->cpus))
>> >+				continue;
>> >+
>> >+			cpu = cpumask_any(hfi_instance->cpus);
>> >+			smp_call_function_single(cpu, func, hfi_instance, true);
>> >+		}
>> >+
>> >+		mutex_unlock(&hfi_instance_lock);
>> >+		return NOTIFY_OK;
>> >+	}
>> >+
>> >+	return NOTIFY_DONE;
>> >+}
>> 
>> [...]
>

