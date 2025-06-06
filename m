Return-Path: <linux-pm+bounces-28212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46136AD09FB
	for <lists+linux-pm@lfdr.de>; Sat,  7 Jun 2025 00:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5571890FB1
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 22:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3627B218AAF;
	Fri,  6 Jun 2025 22:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c+IN61WG"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1D5236421
	for <linux-pm@vger.kernel.org>; Fri,  6 Jun 2025 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749248683; cv=none; b=d0nw2bjLrwSstPmS+At0d7uBbBb7MtG72fByMLiX6EMkKYOtI//ltOUlqq9mnASwuTPrJvkcKOk6SMMcffHkSkvlg8qZkpjSAWlcc0th+4EoAoxG1EWrHtTgz8W4lfYxVpXkEI9JRvH1kQokjRbiXEjIuKu97qZCSo9MsrZPnRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749248683; c=relaxed/simple;
	bh=l/GaUTCtB9M9NLyUMV1ziE5vtpFqMU3SOb/ryyWlAwU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Dom0UYH97BjvC/2oumWtCM6yqlqGdzF3I7A2zNIgC9exoT/v+I0+6HMyLg54dK/WfFpLIwFGggAoLJeidHW5W9rWtY4GdQ+QMt39nbTvlGfwbqjo4vE25dN43xlCydY86RLGKSswuIhU8P0GHM2ULoSMRxOgvf7O9ACgt7bJoBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c+IN61WG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-235f9e87f78so20865065ad.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Jun 2025 15:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749248680; x=1749853480; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0pYG25uNc2n9fOHMKUGQ8EBdQt5+P5oxxO35w9SxQS0=;
        b=c+IN61WGnVRfaeh/PvgYBYwR7I+V0v0JAfS+nhevDlqpLL2U/oMmtMkL4PGH8bwIVq
         yLe0vGCygIO6xk6YFE3gkW+1bKqLpG8rQvcBXg0YqCfov+tWLLEKFxQnaV0otbKp3A+n
         b7TlcA5F1dNLYwvAKy+8IGFOmk9pu/18tTkelW+4ai2QlX2KvLUueI5ke0QdWUqCHsNS
         E38nmY1EFAI4HIyT2gojJaAJXkzY5tEgbz3ATstBN21Xs9Q8g7N2vBLTpubfQeza+u2k
         Rkg78a2UnwjPkPnT12dg39IBU0KJYZ4aV9ygITdz99zv23ZMo427nzQesEldd9v+UCCb
         UPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749248680; x=1749853480;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0pYG25uNc2n9fOHMKUGQ8EBdQt5+P5oxxO35w9SxQS0=;
        b=ol9Td0nU4zVJTje+RHYNGCStG8o9w8EkbXSyhc4BVvAXuROY4xcUKgZfFdrsR3DNHx
         kBy0Fl6efSDV9eMZBYOtNWqDcgUVEQQR4LxxdzFfFq74gp39dEtUvh6zFFORACVcNvvs
         +N+d1zo6nELHBJVNxVQrcjmf5Z0tv4AjOLKXM4HdHSoAXNkp96XbBHgHndzMrXFjmKhS
         TsVFsAV811uIZHeDQPvJG2+Ojaw0HTlgzKo5qiCNcW5aGSY8lCu19f3hdHZMH5hqh05d
         fDBsUlsJfUwdIv2MuzFgQJ8ZNCIkeuVvdtkskpKWEDdXiS2ReUsIfPorSQZRd523lj5n
         cP1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXSEEVd+FX/V2Vj5pF98DFihdh0xa9kzPZTJQSR6hbN+Oh6m+yb+A4FgTJKFJRUz7XPwyZKfaxTyw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIM7d7WA5TgEJwDqs1ACvRz+iu0vZW1D+ot1YGnhmYUvSMlNDQ
	qz7Un+vC/X9xhMUXb+2/eQ/4Bxm2KQmObAPd9pP9HtJWM0ng3e44RZpfwvqa1/L+RD0=
X-Gm-Gg: ASbGncupT0Y2b4YRVCxGOcUq/XeVpskLkCjuFFuIkfdNgjCSXTHLdkk7Bb260mI0+F/
	QsYACwY9MyVN8z5EJgMIXJuXRzpLZG6XYCVIR0oViS5+G7K1rM/pDlVWV5W+Gmoa/aU6WSqGOX7
	xR3Fcc2EBLkHviW1ybJytilRAnoTMYIY/CAUi8QS9V+boQ9GJwN9rwLyGfIwK99dmiTmiybQY6J
	c+iMjeGNQkNS+wJ+cs7MSOHF90sPPX+68AtbqWZBTeDSSkI+hmFYqbNV+f2geZPBSyV2PQ70/S8
	mETElNMy8JK3I7D2Ig8tVLGAuj2H2dgzNHfcEecTB5oWwzdIxfVVR0qWaMLj
X-Google-Smtp-Source: AGHT+IGaFH7zJsEzEYshn2+g3clbSYNKEpXNRLHwkKBWDVvppEVYcd31LnIc2/CbFDj/U8yN0FJ7XQ==
X-Received: by 2002:a17:902:ea0d:b0:235:eb8b:9968 with SMTP id d9443c01a7336-23601d71213mr73856945ad.36.1749248680262;
        Fri, 06 Jun 2025 15:24:40 -0700 (PDT)
Received: from localhost ([97.126.182.119])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603405205sm17150335ad.160.2025.06.06.15.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 15:24:39 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Rob Herring <robh@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 arm-scmi@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/2] pmdomain: core: use DT map to support hierarchy
In-Reply-To: <20250530135741.GA1598718-robh@kernel.org>
References: <20250528-pmdomain-hierarchy-onecell-v2-0-7885ae45e59c@baylibre.com>
 <20250528-pmdomain-hierarchy-onecell-v2-2-7885ae45e59c@baylibre.com>
 <20250530135741.GA1598718-robh@kernel.org>
Date: Fri, 06 Jun 2025 15:24:38 -0700
Message-ID: <7hecvwld95.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Rob,

Rob Herring <robh@kernel.org> writes:

> On Wed, May 28, 2025 at 02:58:52PM -0700, Kevin Hilman wrote:
>> Currently, PM domains can only support hierarchy for simple
>> providers (e.g. ones with #power-domain-cells = 0).
>> 
>> Add support for oncell providers as well by adding support for a nexus
>> node map, as described in section 2.5.1 of the DT spec.
>> 
>> For example, an SCMI PM domain provider might be a subdomain of
>> multiple parent domains. In this example, the parent domains are
>> MAIN_PD and WKUP_PD:
>> 
>>     scmi_pds: protocol@11 {
>>         reg = <0x11>;
>>         #power-domain-cells = <1>;
>>         power-domain-map = <15 &MAIN_PD>,
>>                            <19 &WKUP_PD>;
>>     };
>> 
>> With the new map, child domain 15 (scmi_pds 15) becomes a
>> subdomain of MAIN_PD, and child domain 19 (scmi_pds 19) becomes a
>> subdomain of WKUP_PD.
>> 
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

[...]

>> +/**
>> + * of_genpd_parse_domains_map() - Parse power-domains-map property for Nexus mapping
>> + * @np: Device node pointer associated with the PM domain provider.
>> + * @data: Pointer to the onecell data associated with the PM domain provider.
>> + *
>> + * Parse the power-domains-map property to establish parent-child relationships
>> + * for PM domains using Nexus node mapping as defined in the device tree
>> + * specification section v2.5.1.
>> + *
>> + * The power-domains-map property format is:
>> + * power-domains-map = <child_specifier target_phandle [target_specifier]>, ...;
>> + *
>> + * Where:
>> + * - child_specifier: The child domain ID that should be mapped
>> + * - target_phandle: Phandle to the parent PM domain provider
>> + * - target_specifier: Optional arguments for the parent provider (if it has #power-domain-cells > 0)
>> + *
>> + * Returns 0 on success, -ENOENT if property doesn't exist, or negative error code.
>> + */
>> +static int of_genpd_parse_domains_map(struct device_node *np,
>> +				      struct genpd_onecell_data *data)
>> +{
>> +	struct of_phandle_args parent_args;
>> +	struct generic_pm_domain *parent_genpd, *child_genpd;
>> +	u32 *map_entries;
>> +	int map_len, child_cells, i, ret;
>> +	u32 child_id;
>> +
>> +	/* Check if power-domains-map property exists */
>> +	map_len = of_property_count_u32_elems(np, "power-domains-map");
>> +	if (map_len <= 0)
>> +		return -ENOENT;
>
> Don't implement your own map parsing. Use or extend 
> of_parse_phandle_with_args_map().

So I've been wrestling with this for a bit, and I need some guidance.
TBH, these "nexus node maps" and of_parse_phandle_with_args_map() are
breaking my brain.

So, my node looks like this:

	scmi_pds: protocol@11 {
		reg = <0x11>;
		#power-domain-cells = <1>;
		bootph-all;

		power-domain-map = <15 &MAIN_PD>,
				   <19 &WKUP_PD>;
	};

my first attempt was to iterate over the child domains by calling:

  of_parse_phandle_with_args_map(np, "power-domains", "power-domain", i,  &mapped_args);  

but this doesn't find any entries because my node doesn't have the
"base" property.  So I gathered (perhaps mistakenly) that I was missing
something, so I added:

		power-domains = <&MAIN_PD>, <&WKUP_PD>;

to that node and try to iterate again. Now I got a match for i=0 (it
returns the node for MAIN_PD) and i=1 (it returns the node for WKUP_PD)

So I gather from that that the index arg to of_parse_phandle_with_args_map()
is the index into the -map array.  OK, fine.

So I know that the 0th entry in my -map points to &MAIN_PD, an dthe 1st
entry in the -map points to &WKUP_PD, but I don't see how to get the
child ID without (re)parsing the -map again myself because
of_parse_phandle_with_args_map() doesn't give me any information about
the child ID.

I can maybe see that in other usecases, the caller might not need the
child ID because it's being (re)mapped, but I need the child ID because
it's the pmdomain belonging to the child ID that I need to add as a
subdomain to the pmdomain of the parent.

However, thinking through this, I'm now realizing that maybe the problem
is that I cannot have a sparse -map table.  For this to work properly,
maybe my <15 &MAIN_PD> needs to be the 15th entry in the table (or
technically 16th if it's zero based)?

But before I go down any more rabbit holes, I wanted to check with folks
who understand this stuff and see if I'm on the right track or if I've
missed the boat on how to use of_parse_phandle_with_args_map().

Guidance, suggetions and/or public riducle are welcome. ;)

Kevin

