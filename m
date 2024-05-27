Return-Path: <linux-pm+bounces-8200-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E59BE8D1079
	for <lists+linux-pm@lfdr.de>; Tue, 28 May 2024 01:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0BD72825CA
	for <lists+linux-pm@lfdr.de>; Mon, 27 May 2024 23:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE289167264;
	Mon, 27 May 2024 23:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mXxfFzZw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3434041C79
	for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 23:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716851764; cv=none; b=exsMEmY4mbEZcpVWJJhgPAxlvYXY3cch2JDpA7xcUAi44xS+Jkl7Bh7NrSX9OixlW5X28H/TBRnknBi1FbvV2trbeDhLdr2lFC6qSFV+yi+eWyy+/xOIlyMAbwBXl42VVIhkMotJH6XlyVrWdRzhmIPZUVwPIQIml0K5gQJR7N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716851764; c=relaxed/simple;
	bh=mybrqCieBXpDyCN3cGK2kFHGCjeNghf5MU60VbNyxDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhypABiDxANCwXLoDR+M5aFk/dQT27Ns4ynJe7e+iIoORf128nfspPozqW4V3Gf0Uag1v+lQR6Fd5uVlAUoZFPrBNS4ZOyl/tLd37zHjop1PUNQzo/v+gfh7Iq9HHXZzjZYhNCHRcz83p11dD5qPLT6jNdgCRaQIKeLZ2zQFWm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mXxfFzZw; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e95a74d51fso2014391fa.2
        for <linux-pm@vger.kernel.org>; Mon, 27 May 2024 16:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716851761; x=1717456561; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iKTdzlNEkZJDeB62d/owKD2BDh8/+OHG29/inxAJauQ=;
        b=mXxfFzZwi8EWpPU01Y4tCV3+FjiQ6G5NaNqRvBfsWppolxdw799XQaaFBqDnKbgnZm
         /ViCIghYeECnNTYHo6ymRuxDJ5QAr2QWNiJkHhIzyIUgxBTUFoIYxp/w9p30cB6/xeCa
         b8FoS7OLtDz/hmmofag83inAQQQa/c+UN6JOAATjJ/bTsS+buUK5Pq22SAvrQ1dHv/yP
         qvCskzPz2QZo/hOqLrL7qB5EuupW4UesEFGCt1zoseD7N7C5iTapGqKh1jh62sL6hXZu
         cHb7we9qTkjwOHuy9ZIogfYyXwPvsmmHdyiARwC+herRJICF58J5M3S2b3JdRcirLy28
         p2RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716851761; x=1717456561;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKTdzlNEkZJDeB62d/owKD2BDh8/+OHG29/inxAJauQ=;
        b=jVk14u1avxnKUOVtEEZsHAkGia9WTT6E74CEdLwvt9Cqx6TzZ0TfINvm4Qj7fTS2nn
         a5U5w9DOwNd3dr/k2aOJF14BbpUMLr5RS0SAOmSByqC3I9K91AAej5+ehRJMkhZx1gr5
         CVDxywFsIVjoqJcXkAMbTo089ztILmK7jDmK5RXRuDugBqScTnDRjkH7yx3vQIxgV7QT
         4ylFThqK3+QaiFULbvcJLaGXLJ8DovIV1+4pm/RoCvMnJ06MkqVqiz3tUgM1jRsMvOIN
         XCfVsQ3loj6d3pEPr7fSUtK1w3SMDmCaa3i56T07bXvLTLNX5xICyqUGoRjU8HxFNrXp
         NeDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUROnOcJ6FWn/U/Bbgbqglez1ldiMqBBgjNJPT+r9Y0eUpUyVi76tbLhEigG8GfiPRZbB1f9Jyda+c2oLs0Wacnz9uZ+r/9pbU=
X-Gm-Message-State: AOJu0YzCrGwv00CaJQpa5O+JhtmcdZowzBzFZZjSw7iBjcPbgK1yxZcA
	yVKOqfhGmuyykOwzlhsG7C08hSUzChl5V5ML7iaq2BoFcq7OCl4D9jxE5FgmrWQ=
X-Google-Smtp-Source: AGHT+IEWVatLF+5naW8YkmI1hAhzC+vhZ9ZQCcUWgdC4pifDYGED0voaGL6OUZPFwOrBa6fECwLtOA==
X-Received: by 2002:a05:651c:504:b0:2de:8697:e08b with SMTP id 38308e7fff4ca-2e95b0c1620mr106716491fa.26.1716851761425;
        Mon, 27 May 2024 16:16:01 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e9866d87c5sm956961fa.95.2024.05.27.16.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 16:16:00 -0700 (PDT)
Date: Tue, 28 May 2024 02:15:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Oliver Neukum <oneukum@suse.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Hans de Goede <hdegoede@redhat.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH v3 4/6] power: supply: lenovo_yoga_c630_battery: add
 Lenovo C630 driver
Message-ID: <vc5nd5dl4czkuxzikazn7ndy6wghlchqsrcgxf7n5w53w3o3m2@spyfgp5pwy4y>
References: <20240527-yoga-ec-driver-v3-0-327a9851dad5@linaro.org>
 <20240527-yoga-ec-driver-v3-4-327a9851dad5@linaro.org>
 <ceb1f7b3-2787-4166-846f-2427b44b3e62@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ceb1f7b3-2787-4166-846f-2427b44b3e62@suse.com>

On Mon, May 27, 2024 at 02:26:36PM +0200, Oliver Neukum wrote:
> On 27.05.24 12:03, Dmitry Baryshkov wrote:
> 
> Hi,
> 
> > +struct yoga_c630_psy {
> > +	struct yoga_c630_ec *ec;
> > +	struct device *dev;
> > +	struct device_node *of_node;
> > +	struct notifier_block nb;
> > +	struct mutex lock;
> > +
> > +	struct power_supply *adp_psy;
> > +	struct power_supply *bat_psy;
> > +
> > +	unsigned long last_status_update;
> > +
> > +	bool adapter_online;
> > +
> > +	bool unit_mA;
> > +
> > +	unsigned int scale;
> 
> why do you store unit_mA and scale? This looks redundant and like a source
> of confusion to me.

Here we just followed the AML code in ACPI tables. The unit_mA is a
returned from the_BIX method, the 'scale' is used internally in the DSDT.
If you think that it's better, I can change all '* scale * 1000' to
'if unit_mA then foo = bar * 10000 else foo = bar * 1000'.

-- 
With best wishes
Dmitry

