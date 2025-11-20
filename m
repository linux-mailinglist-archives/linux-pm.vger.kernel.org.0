Return-Path: <linux-pm+bounces-38244-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F50AC71A2F
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 02:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2F85F4E2DD7
	for <lists+linux-pm@lfdr.de>; Thu, 20 Nov 2025 01:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A817217F29;
	Thu, 20 Nov 2025 01:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lhzTm0Qc"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98052556E
	for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2025 01:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763600503; cv=none; b=rjsUZ54cyIvqdIS8Kwv/J/jLcIjTzMNCOr7nVTRqaLpE8gknx4UYQ2Fn2Z1Rb/ydJcwU7csC8AK0elHFsS37NOzUk14TWb+dTlqiGsFGnwjZO71yFmfq5Lf0ClSAkjez8E+xyGFuF0M/XgFiV9Dce7fS8pMaatNyWIEcyUYbIp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763600503; c=relaxed/simple;
	bh=S1kXvrn93cUEzs6slAKgNy4bH/LtAkdBKIXZyolnmdQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tqAX3lduO5RGfiAZJUsyx5OaLeZVMdhvqAr0BdG42i1nDFbrXWE7BvlAweFH94l9Oa8ASgaxtF2RGBu60z3SUiAtRJyDTGFwv1n/p0yqHwnu2wbIqmsRktCmiYQ+N8Crq1Qv2M1BuCnZfUfIBpmaEhVUx1auoWs5n+hVG9qSy1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lhzTm0Qc; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-297dc3e299bso3767295ad.1
        for <linux-pm@vger.kernel.org>; Wed, 19 Nov 2025 17:01:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763600501; x=1764205301; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eIEhL4VxM7ghK2mG+iC47nZUgip1BfB1tOdqThTNDgY=;
        b=lhzTm0QcxdqtPS1J4JbnNJt5ajkk/hdh8WuxmYfXVUw6pTKP4b7vU9lTFeGD+su3/z
         NRToEiG/D2qjElPhlJJfpMSPKwTHb9Rrn+At8Cpx/rb+8eVihs0OtC/Un+VRDfvWQHrS
         Hb7NxJq3md3oYXu3Ur6IcahIUxJy7ZYlVCOSPZ4p15/xsSQy9Q34fs4s6eY1DMsW1kQC
         H7k1++cuV+0ollpGjg9sABJNGiaPK8bM2G2x5dofh/X7G1sLslw5ObHR0FCfv4RAul0h
         T6dCEZEAsAvDz2i6ICXTCZVxZ9HPuebPbdIlQjpXN3lDeKTvjTJ70SQlPtx1ILYLOBd3
         G7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763600501; x=1764205301;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eIEhL4VxM7ghK2mG+iC47nZUgip1BfB1tOdqThTNDgY=;
        b=ZCaTautjMRodkp2QSpOoXAu9BnneWfIADY+GWoRdgZeOELAUYVCZ4OBczS4d7iye/J
         KzYMsQmJkGHsGUHqA1F63c+Vmk4Uytmh9hM40qzFj5jTJFjVxxbAZa0iInMi7MYzXej9
         ixbHSDrzRbHCIpff9AzpPn6B85YUgwTaq0H3k0jlJctjfkETBPMNK1CdHhsArkxibR4g
         /Kd6IBLFbU+0SHX23G7qal1V+v9IKtqxDlCHhc/4tYAh4JfJaaNvFJt3h25lki1rYeVk
         AgTT3w3USKbvDRkttMp80D63L9lYaeeazU25XEWmyPusIWREgLegteVX2ZIuiswhyYGU
         pV+A==
X-Forwarded-Encrypted: i=1; AJvYcCVylVOo07/FI5NmBK4GVCsQ0bHeGZPJCXhj/T6tmOn0QOE94d2rp5mmfBLOF8W5ajlYGiZ2zLqhjA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxXYtBfnaZ44WuyWcj4FT77LX84yB0kkNRv0R0CUZL0jafSOiR+
	aLCf0nRy/O915mU110+QLEvcbYBVd5Zukvv42uMqEEGhRojdA2LMH5cVPu7+U29kiYE=
X-Gm-Gg: ASbGnculiSZJpo128ANRsZjx3PqImm2d23fIiqW9gtUWveUgQ25OE8s+hp3TXBMxYSB
	mdj/GW++/FH2N7cZpmGVD4m366QP9FdlJzOyk+RPpaTDqh428YhSk3qtOs4EuoZko1JYhKu2092
	n/OpCG6gVqbMPm+ijjaEA0r9R2bwLoTJ1wvaf3xBZXjjhztssPmwjs1/ViL22RkJ7E4gN5gRhFi
	7j9WycJ+MApwemNdsmyINfxRA2r93NdlYlTFX/7yQGAeaHSi0grkY8/gtiMC+XBJVRuYNMXkqHV
	y+x3qvKPYeuJ6dXUTfvgJS16kVJ3iuFRvAneqYpV5k6xVdm1knEddZ/0Xp20JndwKBofiWJF3cl
	es3l/NwBMKNV2GRhJK+wJ0Y0iKA3d3wbI0NM+XYB+/W9l+FzgbUatjQdUg0R1Xz9L1fUMXHRr63
	StIxDYB/2EOP+IGs0QTDE=
X-Google-Smtp-Source: AGHT+IEqw78cftsDU7YZyIRB0CXtzePRU0iLnoit3ob3znYZ+DZXTr4p0cuA9rJuU7Vz7Z+gxqqtDg==
X-Received: by 2002:a17:903:1a43:b0:296:2aed:4fab with SMTP id d9443c01a7336-29b5b05b6damr14930755ad.23.1763600500485;
        Wed, 19 Nov 2025 17:01:40 -0800 (PST)
Received: from localhost ([71.212.208.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2ac81bsm6687805ad.93.2025.11.19.17.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 17:01:39 -0800 (PST)
From: Kevin Hilman <khilman@baylibre.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 arm-scmi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] of: Add of_parse_map_iter() helper for nexus node
 map iteration
In-Reply-To: <20251119-topic-lpm-of-map-iterator-v6-18-v1-1-1f0075d771a3@baylibre.com>
References: <20251119-topic-lpm-of-map-iterator-v6-18-v1-1-1f0075d771a3@baylibre.com>
Date: Wed, 19 Nov 2025 17:01:39 -0800
Message-ID: <7h8qg1frf0.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kevin Hilman (TI.com)" <khilman@baylibre.com> writes:

> Add a new helper function of_parse_map_iter() to iterate over nexus
> node maps (c.f. DT spec, section 2.5.1.)
>
> This function provides an iterator interface for traversing map
> entries, handling the complexity of variable-sized entries based on
> <stem>-cells properties, as well as handling the <stem>-skip and
> <stem>-pass-thru properties.
>
> RFC: There's a lot of overlap between this function and
> of_parse_phandle_with_args_map().  However the key differences are:
>
>   - of_parse_phandle_with_args_map() does matching
>     it searches for an entry that matches specific child args
>   - of_parse_map_iter() does iteration
>     it simply walks through all entries sequentially
>
> There are likely ways to extract some shared code between these two
> functions into some shared helpers, but I'm hoping someone more
> familiar with this OF code can help here.
>
> However, before refactoring the shared code, it would be good to have
> some feedback on this approach.

For a bit more context, the need for this comes from the work in
drivers/pmdomain to be able to create pmdomain hierarchies using a
power-domain-map property.

I just posted an example user of this functionality here:
https://lore.kernel.org/r/20251119-pmdomain-hierarchy-onecell-v4-0-f25a1d5022f8@baylibre.com

Kevin

