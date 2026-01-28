Return-Path: <linux-pm+bounces-41600-lists+linux-pm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEqJNTnleWl60wEAu9opvQ
	(envelope-from <linux-pm+bounces-41600-lists+linux-pm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 11:30:17 +0100
X-Original-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 295099F7A4
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 11:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FEFD3008A74
	for <lists+linux-pm@lfdr.de>; Wed, 28 Jan 2026 10:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885242E8B6B;
	Wed, 28 Jan 2026 10:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tvmdDEgf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92D22DC35F
	for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769595983; cv=pass; b=D9iYvq5GRQTZ4p7Zq7su+i2jFB/ZNnr8vPngUBEPEBP5ArhpeySr2M6y9kbE/AYj7GTC4AB9sD7OT2AnCwG52SS5scQRjBnAbGhayWQJ5rPR6mMM50tq5rGuIL6I1Mgs2JFgtNow0sD/RezUvPqs1u8gjiA/L+tw8NewgEKGwGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769595983; c=relaxed/simple;
	bh=DptfAq8hZbrqHIzwkpl2dxgpsvMJPvC9DG8ql8p0SOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QcqKCUxJkYAZ/RezRuBfaXG9G+M+q68M6WS+oOTiewbg1QW8nrPffgOxWS/ZWrCv2NnnZx7pNJ1B51h4Lfd4XFGDR9sIx77aN1y58Bn+8pl50PxMQA3co9YOoPn04WEPZdDb9L0FBRTEJeWxO/AB6gdeWfg79f+f39o6XKA9yng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tvmdDEgf; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59de66fda55so6018462e87.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Jan 2026 02:26:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769595980; cv=none;
        d=google.com; s=arc-20240605;
        b=Zh0aSpI8AIJZiKMfxzubdzSLU9kVbgEDXFBF0ZTe1sZdiWv0LTiT+muf6cwaclLfJS
         6nA2wVCRK4WhdSQNeavgozModxMyjeAUkxrH6w0z+pCh9Ry7MmPrmud/T5Jvant+Qkr8
         /OrjNllgWphbdIOJNUjoV0NKpfwaalV9M7Eg62JgwNWoOjPI/w1gjgvl4YXhedfCoDa7
         doJ1AsADHOrBY3zGu69DH9vQlp9qqCWiTxQpwrZgOhvaU9k92xGcjYcy+ecMRPSDsfm7
         HxhaGtW1bGGoc+Q8tak4G2nkWeiLlhvPAmIyjfUGJTxYg+sOH3yqHByeno/olGWDVs1a
         HwoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f/9ZEPms/NHM1qq4KRT3DLn0UH8x8Gn6xpRE3AZ0+BQ=;
        fh=sj6n93nED1MONCA2HM65VFZedzLYVLyZKW0Zp8SrEFQ=;
        b=j9FQ6QrPdcdtdJQ0utjWgwEGAc0/pcPXnFdzm5ClG8etSfKz3wRFPjK3PpPWCmZLJV
         tSzdzz4MGXX57vdKisfPKvbyXfpjeazoyntokmglhrDVs84DsoyGG2ON7uH4DSj/k/Ip
         FRAxujKgJLzlKr2Mcl/tWaWPLIrSRQ+WQuBC4ioIXyMU3cTFVDDootc5syCLQ3BEO4iC
         VaZ/HmIQh3GvmkWbom41XwZu/yh7ptw1ehWToX/g9At+c7/uaYQdD8ngauc5zGenWFpc
         0ZJPEnPd6HxDOnyRrSMs338dbYmKTi9Z2agDaI3Ruat8Er3F5cP1zkC7WFa3EmYsxRqe
         kiag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769595980; x=1770200780; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f/9ZEPms/NHM1qq4KRT3DLn0UH8x8Gn6xpRE3AZ0+BQ=;
        b=tvmdDEgf/UCC6xwHPXsT3yEybpXgd1I9SD9KkVuV4nHIns1ro49FFicrDM0X5pHicW
         vR1zFrO7thoctVTf49bGdkDjxQzLlLt1BW5QITXoRyRqXcQTOYGsyKYKg8sHKP9f3CJE
         GYXFt1WZtuBfJ8BOsMzCOBo2ClT4uPz6OzyUUF6PBaVww67tkh6RrRIqbeq+X0dWNtXy
         gvc++ymCJNpOds/MqKkRfcdqZzQeplOo3L76PVi5+6pPWSLNnDheq6O4b6R5yLozGi/G
         5SR+o7O5npdRS4go/WsbcmMn3DTZyqiAMBbsMiNywgrOEreFBEXyKVx6cnDZvfvIihTk
         zv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769595980; x=1770200780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/9ZEPms/NHM1qq4KRT3DLn0UH8x8Gn6xpRE3AZ0+BQ=;
        b=g2lNvyhBdgmWV6SkpDa9o/EK4KAAeM95ks3rx+0x00VDIx0J9yIe16Ef9O6ivrk5b4
         VP3IdaULhIEDQybjo6i4OwY25gvZn6Y+Ur1eP5ziDXQFd9NJaXzFA4lmvquxN3tX2YMx
         MSCAC5cCqW7Wo5IXUeLpKspDIN8V2Gkd3f8odwGdtQMhEf2+I0XaoXkuH0xvU2THosMG
         Iwccuo8W94qmdteHwFEO4orHVjbIfGumdEOoHrYxElzcFp6EJISsbLVG69EWtihqKibM
         +DIkJCnd4O/hZfrfjV5o8PkTePYXNQ5C+6v5+Z2mINF2OO2MXRN5QHY2RAh8Oy41e5yB
         Au4A==
X-Forwarded-Encrypted: i=1; AJvYcCWTmqwwYVqzZF3pChDgkYxr6J6oL4SPBwKaJnbfFKULG38PjhVPlzcYYxr1B/VD0MfoUBEEDgBx5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUjCHMHwaffy2joSLdjkp1WfagFtMzjSTKJvoDlt11jhZLB67B
	fhq9DUfeO8B42WqAt5Po0F+dzGdxinOzNBiPFI/Yh1xZw4H+yqhR/gtcRn5OlP7HuD5T+qgsh0A
	mIVwNPd9hEqr4YiF9AXdc6ZzoQVcG8caeDuYUldP3gpnD3UhgKprCqAFU3A==
X-Gm-Gg: AZuq6aLp1pgHD5UcaGzaqh/Jvw9znP3HnIJ7r+h4t+NBUwRBP4KoaYB0WLmEX2PzBcv
	B17D1h+EoHlBkv/kmv4OxX7E5MQcorjN+AOViriQsUbZoXXW1HqdWNVYA6qICb0KvZerXfGniRN
	gdJgnUCc6GvdcYwOHD8VrORjvnf6Qik74MilXk8Go8vWjciAuF1/oae5BxlVSJ+8wps6VxofdBr
	Y9ktZMwNNA5SrG7AuTt7qUHhux+TiTelxMx9isDjE2NdS/fPhhkrTKN5mMCIKWDCQS6KJKm
X-Received: by 2002:a05:6512:4003:b0:59d:effb:831e with SMTP id
 2adb3069b0e04-59e040246bdmr2225871e87.30.1769595979831; Wed, 28 Jan 2026
 02:26:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120-topic-lpm-pmdomain-device-constraints-v1-0-108fc4cfafce@baylibre.com>
 <20260120-topic-lpm-pmdomain-device-constraints-v1-1-108fc4cfafce@baylibre.com>
In-Reply-To: <20260120-topic-lpm-pmdomain-device-constraints-v1-1-108fc4cfafce@baylibre.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Jan 2026 11:25:44 +0100
X-Gm-Features: AZwV_QjZD7V9bj1bchtCaHSRRos39IgEJ9xHiGXoFOAlIryGcR90_WwNYIBekwM
Message-ID: <CAPDyKFoMcAo889jcfb6nGFUVabsvTDme3yWkW+f0xtfRWPtaxQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PM / QoS: add flag to indicate latency applies system-wide
To: "Kevin Hilman (TI)" <khilman@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Dhruva Gole <d-gole@ti.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[linux-pm];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:dkim,baylibre.com:email];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,linux-pm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-41600-lists,linux-pm=lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+]
X-Rspamd-Queue-Id: 295099F7A4
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 at 02:54, Kevin Hilman (TI) <khilman@baylibre.com> wrote:
>
> By default, the QoS resume latency currenly only applied to runtime PM
> decisions.
>
> Add new PM_QOS_FLAG_LATENCY_SYS flag to indicate that the
> resume latency QoS constraint should be applied to system-wide
> PM, and *not* runtime PM.

What if we need latency constraints to be applied for both runtime PM
and system-wide PM? Can that be done?

>
> Signed-off-by: Kevin Hilman (TI) <khilman@baylibre.com>
> ---
>  drivers/base/power/sysfs.c | 27 +++++++++++++++++++++++++++
>  include/linux/pm_qos.h     |  2 ++
>  2 files changed, 29 insertions(+)
>
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> index 13b31a3adc77..9136c13c17e4 100644
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -316,6 +316,32 @@ static ssize_t pm_qos_no_power_off_store(struct device *dev,
>
>  static DEVICE_ATTR_RW(pm_qos_no_power_off);
>
> +static ssize_t pm_qos_latency_sys_show(struct device *dev,
> +                                      struct device_attribute *attr,
> +                                      char *buf)
> +{
> +       return sysfs_emit(buf, "%d\n", !!(dev_pm_qos_requested_flags(dev)
> +                                         & PM_QOS_FLAG_LATENCY_SYS));
> +}
> +
> +static ssize_t pm_qos_latency_sys_store(struct device *dev,
> +                                        struct device_attribute *attr,
> +                                        const char *buf, size_t n)
> +{
> +       int ret;
> +
> +       if (kstrtoint(buf, 0, &ret))
> +               return -EINVAL;
> +
> +       if (ret != 0 && ret != 1)
> +               return -EINVAL;
> +
> +       ret = dev_pm_qos_update_flags(dev, PM_QOS_FLAG_LATENCY_SYS, ret);
> +       return ret < 0 ? ret : n;
> +}
> +
> +static DEVICE_ATTR_RW(pm_qos_latency_sys);

Shouldn't this code be moved below, inside the #ifdef CONFIG_PM_SLEEP?

I also wonder if "pm_qos_latency_sys" may be slightly too short to
allow the user to understand what it's used for. Perhaps we should
rename it to something along the lines of
"pm_qos_latency_wakeup_enabled". Just a thought, no strong opinions.

> +
>  #ifdef CONFIG_PM_SLEEP
>  static const char _enabled[] = "enabled";
>  static const char _disabled[] = "disabled";
> @@ -681,6 +707,7 @@ static const struct attribute_group pm_qos_latency_tolerance_attr_group = {
>
>  static struct attribute *pm_qos_flags_attrs[] = {
>         &dev_attr_pm_qos_no_power_off.attr,
> +       &dev_attr_pm_qos_latency_sys.attr,
>         NULL,
>  };
>  static const struct attribute_group pm_qos_flags_attr_group = {
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 6cea4455f867..aededda52b6b 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -37,6 +37,8 @@ enum pm_qos_flags_status {
>  #define PM_QOS_LATENCY_TOLERANCE_NO_CONSTRAINT (-1)
>
>  #define PM_QOS_FLAG_NO_POWER_OFF       (1 << 0)
> +/* latency value applies to system-wide suspend/s2idle */
> +#define PM_QOS_FLAG_LATENCY_SYS                (2 << 0)
>
>  enum pm_qos_type {
>         PM_QOS_UNITIALIZED,
>
> --
> 2.51.0
>

What about documentation?

Kind regards
Uffe

