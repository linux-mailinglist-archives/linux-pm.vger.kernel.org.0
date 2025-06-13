Return-Path: <linux-pm+bounces-28705-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94443AD9857
	for <lists+linux-pm@lfdr.de>; Sat, 14 Jun 2025 00:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694E3189B50B
	for <lists+linux-pm@lfdr.de>; Fri, 13 Jun 2025 22:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B780328E61E;
	Fri, 13 Jun 2025 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3eMhKBcp"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173CF28DF04
	for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 22:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749854600; cv=none; b=rAG/74ePjIua5LfUoRIYtlmY6sNHmQwocTs+NmyddPx/9RTLQK1NjMEXb91g3pJ4OROK/a2bAjr50ayE9K/B4BDxoUL133+KKYQmKOvwdavf2mnVGnudJxf72d7p46kfr06Ql1XxceXhzB5E+tLtXIhPl91mh6cyoNaMC5vMdJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749854600; c=relaxed/simple;
	bh=PZrzJBfxwUQlI1Uzz/TyzWB8qQ8Tus1wq/Wfnb0hzOY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dud7DFcwPuNdWQv1bJdSnwsXbkWdjXK5nthBFTyeZJNuWOvd5BbMCIaxG3DBYFs4lc6MmwDjDOA8sGJk2eGdua8wvTkwfN+Tqh/94e1gryXzkmbPgVWdq0JCEc/EPzQpb06UhfvkHgZTIcyrHNumcEiPJIO5OoTyF4GV5bUVpp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3eMhKBcp; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b2c3c689d20so1949669a12.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Jun 2025 15:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749854597; x=1750459397; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=e1D2utH8U9KD76szVdYR9Vz0lt+nUusqTvhf81ggVEs=;
        b=3eMhKBcpeyt57vQW3P+TX4IBVd4hT41m2UmlobjxvICCd/E1lzi83tDfmc+1OkGBW0
         ZqbV4hXkf0eY7tYcbLnxDu8rxqU5zIy4/UDeaH5gw9m/5fJyvpGHQjcGhBjTNZ9Z7HQi
         3xf2wyYU5vi/g/qOLWbrS71iZHE+XeFMQDQXytYQv8IaRp5FgbTK7RJCy50uTFPsvok5
         wksalRAX3TrRRFi4QyvFWi4TjzWIoiErBYngAwe6EKvUSgytBeNE+IiM2AUFPzrjBVSO
         RRY9IrBc1YMxdHMRpIoYVsIRZddDjxj4QuVNVwOFz0xpaM9MKSvQye9+jsc48WSMhW9P
         Whow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749854597; x=1750459397;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1D2utH8U9KD76szVdYR9Vz0lt+nUusqTvhf81ggVEs=;
        b=bnB+XnPShEwIOlqpfcZ5syLhTPW2QP4mpySkP/gh8qHUGk0ZqOBAcTmBJGexoLKae8
         0wCNGFdbH98jhRHDxqqmpRO0pK3Kp3034nd55rGSHdA/cXXUO6c246sLpwyxEGvoc0jo
         SFuwAUxz/AwUfo69nLZVvLtsSU70MkzdrvyRieFZjmtORQVTMoYns4qNKr5r9YoISpIH
         83U4bqbzYloiGjzvg+rGJksdPKhrqNb5EFP1So41kIrqTYTxTXJrRhbkVHvjHGQaMWPx
         g7j0kFpxpw+z3/wzjubfGPdZsCLv/WqtnQJLEygOO55l3fmkWRbbJ1lU/nPw1sHX5N0R
         ulOg==
X-Forwarded-Encrypted: i=1; AJvYcCVTBwnSlzXzeb0rD2zeloWulhbe3alx6+Yzs3Dy/9bQZeDUmBfLS4+zl+NhllXnyUxt5mKL0Npb6Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyV0YpFDb/BKthQkssitB4X9uqKBLuC7pMc4iCAVjT2JK4ZiGea
	tEb7PvIkOUmkBgIKkgpWI+gUrdmOFBBn6dHXi8UG1r23bGgcwAceh4qIRRI3q9sw6mg=
X-Gm-Gg: ASbGncv68dLkFpzjvGUZjAIrFip+z1RFYCWLk/cdAtpi3r1x6PcNKPIEEHAW5B/duqk
	0Xz7KlEdIoPP13y+d2TcdQyjsQEUSr3s3b2Tzw1sG9WE1Do12KQMNG4io16RKI/VLgxk4avGVxS
	oD6WZEInIFf7ySDm0qXny3/kGqDT9liAD9+8zOMdazou6tN+RuxSYrqq31v6iKXh/O1jANqyT96
	Gy3DIvU8vFBq1CbAqEgGOh6onHbisE3G4Zh9ckcYxmzxFHRHhQMGvl98ufzXq2c3N1xcX2ThrH1
	xusXvIDk7MetaAq1nIJiI9uOwMSOTveTF7Hn4YzBLJiH2k9G8Xn55kO2iB6Zu5KYVujHRHE=
X-Google-Smtp-Source: AGHT+IFKzeJY5f16SJqI4Du+DmbC+0tBVm+HCX+tatOdiKu/4UYBoSQ1IXdPpifz/+y48zCjM8UQgg==
X-Received: by 2002:a05:6a21:998a:b0:218:bbb:c13c with SMTP id adf61e73a8af0-21fbd5dc861mr1371682637.38.1749854597404;
        Fri, 13 Jun 2025 15:43:17 -0700 (PDT)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe164406esm2321129a12.27.2025.06.13.15.43.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 15:43:16 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 arm-scmi@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/2] pmdomain: core: use DT map to support hierarchy
In-Reply-To: <7hecvwld95.fsf@baylibre.com>
References: <20250528-pmdomain-hierarchy-onecell-v2-0-7885ae45e59c@baylibre.com>
 <20250528-pmdomain-hierarchy-onecell-v2-2-7885ae45e59c@baylibre.com>
 <20250530135741.GA1598718-robh@kernel.org> <7hecvwld95.fsf@baylibre.com>
Date: Fri, 13 Jun 2025 15:43:16 -0700
Message-ID: <7h1prnqn3v.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kevin Hilman <khilman@baylibre.com> writes:

> Hi Rob,
>
> Rob Herring <robh@kernel.org> writes:
>
>> On Wed, May 28, 2025 at 02:58:52PM -0700, Kevin Hilman wrote:
>>> Currently, PM domains can only support hierarchy for simple
>>> providers (e.g. ones with #power-domain-cells = 0).
>>> 
>>> Add support for oncell providers as well by adding support for a nexus
>>> node map, as described in section 2.5.1 of the DT spec.
>>> 
>>> For example, an SCMI PM domain provider might be a subdomain of
>>> multiple parent domains. In this example, the parent domains are
>>> MAIN_PD and WKUP_PD:
>>> 
>>>     scmi_pds: protocol@11 {
>>>         reg = <0x11>;
>>>         #power-domain-cells = <1>;
>>>         power-domain-map = <15 &MAIN_PD>,
>>>                            <19 &WKUP_PD>;
>>>     };
>>> 
>>> With the new map, child domain 15 (scmi_pds 15) becomes a
>>> subdomain of MAIN_PD, and child domain 19 (scmi_pds 19) becomes a
>>> subdomain of WKUP_PD.
>>> 
>>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>
> [...]
>
>>> +/**
>>> + * of_genpd_parse_domains_map() - Parse power-domains-map property for Nexus mapping
>>> + * @np: Device node pointer associated with the PM domain provider.
>>> + * @data: Pointer to the onecell data associated with the PM domain provider.
>>> + *
>>> + * Parse the power-domains-map property to establish parent-child relationships
>>> + * for PM domains using Nexus node mapping as defined in the device tree
>>> + * specification section v2.5.1.
>>> + *
>>> + * The power-domains-map property format is:
>>> + * power-domains-map = <child_specifier target_phandle [target_specifier]>, ...;
>>> + *
>>> + * Where:
>>> + * - child_specifier: The child domain ID that should be mapped
>>> + * - target_phandle: Phandle to the parent PM domain provider
>>> + * - target_specifier: Optional arguments for the parent provider (if it has #power-domain-cells > 0)
>>> + *
>>> + * Returns 0 on success, -ENOENT if property doesn't exist, or negative error code.
>>> + */
>>> +static int of_genpd_parse_domains_map(struct device_node *np,
>>> +				      struct genpd_onecell_data *data)
>>> +{
>>> +	struct of_phandle_args parent_args;
>>> +	struct generic_pm_domain *parent_genpd, *child_genpd;
>>> +	u32 *map_entries;
>>> +	int map_len, child_cells, i, ret;
>>> +	u32 child_id;
>>> +
>>> +	/* Check if power-domains-map property exists */
>>> +	map_len = of_property_count_u32_elems(np, "power-domains-map");
>>> +	if (map_len <= 0)
>>> +		return -ENOENT;
>>
>> Don't implement your own map parsing. Use or extend 
>> of_parse_phandle_with_args_map().
>
> So I've been wrestling with this for a bit, and I need some guidance.
> TBH, these "nexus node maps" and of_parse_phandle_with_args_map() are
> breaking my brain.

OK, nevermind.  I *think* I have a better grasp on how they should be used
now.  I've submitted a v3 of the RFC[1], but could defintely still use
some guidance.

Kevin

[1] https://lore.kernel.org/linux-pm/20250613-pmdomain-hierarchy-onecell-v3-0-5c770676fce7@baylibre.com/

