Return-Path: <linux-pm+bounces-4496-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777AD86A8B2
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 08:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B16AB23675
	for <lists+linux-pm@lfdr.de>; Wed, 28 Feb 2024 07:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9794D22EF9;
	Wed, 28 Feb 2024 07:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw/r3Z7J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC460225AE
	for <linux-pm@vger.kernel.org>; Wed, 28 Feb 2024 07:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709104159; cv=none; b=VB7nK7BsW6fPMHRYMpIgsm3NyccROY7I+T7vtT4SLzqju98KIPm8Ver00f+/kMRLSicYmZlgIlUXUSalZd6kfDRC8AS/NLc9IxAnJ0LwsAxgcXQ7h2c4ZJ/LB5D++U1Jaru/aiOIcFGOOVDjV2e6ii2x+nKAUr7lSlkhfNkr5hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709104159; c=relaxed/simple;
	bh=KVn4lP/YdqAkaCKQTWUKaBFCHql/sicZL9qJ35MAImI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJmtZYPF2NRjZ8mtMZY4up0hZ8PcKKTovSaKiJiI9xoPTNCfb8xQP5kFdDOy3Xdo7Ts0suCuYzpv8vjjzvgT305rD5FF+Exyvc/JcMlYfmRPRp0CQK+U45WGvPaKNXcRx3x13ZqmyF3eQ1zxRhgNze8dDjkcDdpnvya59Qq39MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rw/r3Z7J; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-513181719easo598276e87.3
        for <linux-pm@vger.kernel.org>; Tue, 27 Feb 2024 23:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709104156; x=1709708956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Uieoz5/OagDiVtMTFykQikVnN0ZfGzb3C1jH0haSWU=;
        b=Rw/r3Z7JNXaR6G5Q8bsbvZi6CCf9YI3Oz9lAinySrOJBKsdRdBD4mB8giblZqnogUB
         9HC29VyeR+UniGUUSbk74aOWokNUGt94c6GD5Qw1LJUAiFQq5eqgGNPzz0vOQ9NWH6V1
         fkzx50G2zMvg32G/HfgQDVImYe7k/8DGZBjjaKRwI5+S7SJzDfqpm4Pnhz+EI1fOqiDR
         iLDgekgtx5TuNadM9ggQoRaJQ3UoVIm6qnC9i7V+B1RXV23RCERPg8QQdYOpXA+ovBMt
         ytclBl8uOgtX/q2k2DnOq+3PJ6yI3exhrayA8FzSv0C0jE/hXCwXW+iN8jk/+otULAU5
         jACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709104156; x=1709708956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Uieoz5/OagDiVtMTFykQikVnN0ZfGzb3C1jH0haSWU=;
        b=aLKV25Es5zV5c5aykC+Kjgtr1XXq8MyXX4LgLM9FWA9PLStK7zXAh8/3K9KPXn40kS
         kjqe3tYy9zi12JvuTFLvLh5R+Mti2qyPhdQ4PeopDHpp1C2uPwYllyvsPNPzoa5WTJX0
         Kkzy1tYlVW1y4U0tzaA1FLxuCElORWTeJ5inCW1tD5f9m1YXXOmaOlwx93/9Lw67TyXv
         V+4enXvB2WNN5F9jlatY+wKtNrscV5kZFD3uj2tDA7JlG5MOfceNtBT6CQrl4rhPmScb
         xNUMZbrkT5jeF/U/7D7WOR97AQKxDWGCSD1Yb/ToUzFaSO2nniFdUeGBv6QrK80Ubjld
         u6xQ==
X-Gm-Message-State: AOJu0YwqFTz0OfMaWKKiMnPPeznGbDXnDYQIJA4QPHimBkpnIBSU8BpO
	LdfL5td2qYXfdneefrXMF88gJN9sq23eB7f7x2iJ0XtUe+9qpWftjl7q0HnJ4aIlWw==
X-Google-Smtp-Source: AGHT+IGbY+/poKAYzLtifACXY7FpF8AL+LOrOveWv3IZDmQMiUoymrNkzQGlUCIYlSjlKzQ8IHajhg==
X-Received: by 2002:a05:6512:10cc:b0:512:fa28:c488 with SMTP id k12-20020a05651210cc00b00512fa28c488mr7404918lfg.65.1709104155610;
        Tue, 27 Feb 2024 23:09:15 -0800 (PST)
Received: from tp440p.steeds.sam ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id ba21-20020a0560001c1500b0033dc3fe1046sm12837775wrb.77.2024.02.27.23.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 23:09:15 -0800 (PST)
Date: Wed, 28 Feb 2024 09:09:11 +0200
From: Sicelo <absicsz@gmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-pm@vger.kernel.org, maemo-leste@lists.dyne.org, pali@kernel.org
Subject: Re: [PATCH] power: supply: bq2415x_charger: report online status
Message-ID: <Zd7cF_MNCKg51f-B@tp440p.steeds.sam>
References: <20240226194432.2174095-1-absicsz@gmail.com>
 <6slfmvqmtawwjlsobcfod6ewcjjbzmylz3owsdamdi4dod55wr@iiox5rzjj5ht>
 <Zd5VflcLb3Es1xiJ@tp440p.steeds.sam>
 <5l3e3bkultb24kawad4vh3j4c6lo77i6hftumo234qgtwbk4jr@z7kbnrcgbdel>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5l3e3bkultb24kawad4vh3j4c6lo77i6hftumo234qgtwbk4jr@z7kbnrcgbdel>

Good Day

On Wed, Feb 28, 2024 at 01:00:20AM +0100, Sebastian Reichel wrote:
> > > 
> > > 011 - Poor input source or VBUS < UVLO
> > > 
> > Absolutely, yes. This particular state, which is a fault condition, clearly
> > indicates VBUS is present.
> 
> I assumed this might be set for a disconnected charger, considering
> that no input source is a poor input source / 0V is < UVLO.

The meaning of that one can be phrased as: you are supplying VBUS, but
it is not high enough for the chip to sustain charging.

> > However, looking at them more closely seems to suggest I should respin the
> > patch to also report VBUS online if a fault is reported instead of only
> > during charging and charge full states.
> 
> Right, so you can just check for BQ2415X_CHARGE_STATUS != 0.

Thanks. v2 sent.

Regards,
Sicelo

