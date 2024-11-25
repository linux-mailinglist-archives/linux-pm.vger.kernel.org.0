Return-Path: <linux-pm+bounces-18011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E999D7A32
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 03:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 541BBB2171E
	for <lists+linux-pm@lfdr.de>; Mon, 25 Nov 2024 02:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DEEEAF1;
	Mon, 25 Nov 2024 02:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aKF2TFYa"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31E2539A
	for <linux-pm@vger.kernel.org>; Mon, 25 Nov 2024 02:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732503012; cv=none; b=TyN7KwjEo8ZwaGkmsCI7lFWNt89Sc8ei/OKKTbVND3dr0uVSQF/WOCfVrZsq4hK24BMvW9mS7OF76gx9DPQrsAVK3FxhfyVP6be9lcuImRea4/QZawEvEjTPXCBxSTgj0jrtNgWVpQJDG9qj4q1jCPWCnuPr5kbKetdWoFE9zZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732503012; c=relaxed/simple;
	bh=9xWE7hQ80NTsubhmPzd5LMYo1B+VsjDN48zEUFNEFDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcTtYnbqKpbEJ4BeA8OywjnxGSybFYbYt4qIdRaabihp43bODrPDj9X9qxR3TW+iqApqZZZZC0BLR8gZhNWSb49UHK53l7DbPgFkFDKZ8cOlw77UVKesB60fg3NUzTqhYxfRbsxIFlzQDyQwFW8ZZF0M6Jnz+xSp2yJ3Bn85/7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aKF2TFYa; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-720c2db824eso3940384b3a.0
        for <linux-pm@vger.kernel.org>; Sun, 24 Nov 2024 18:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1732503010; x=1733107810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LuaL5qYMw6VKISBfy57xcOAOGx2kf2U0nHPjc0yVGaY=;
        b=aKF2TFYal75cyB+eski0+oeXjwto0FStjBNyKUSsVTvtOaBVLHznOd/C9XHGy5hbm/
         puedsijJr/5B+wvH373XUaG6r/b10nqnYpO85UKcTa7cuVX+OPMopVG4bFiwGY5hvVZW
         Bej1/m4L9+2BxMKpVSdwsXzA838VYHJADpccM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732503010; x=1733107810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuaL5qYMw6VKISBfy57xcOAOGx2kf2U0nHPjc0yVGaY=;
        b=Gu8gsY1YeF9WGs7ASYPcecLC2olYI1+rM+O8fmRqkh0+Q+tVp00y6MS/T3mMzbOBK4
         iikO5Vz1Nh88ITTfiZ+1YVsvwJPMuhNRN0tXWfJqQHiEKkc4zr3aB2WBrWjPrRSn6J3z
         9vGAMsJuTxf5s+7BUIC0fSHHz4IaS3q2qTIrooizYrgr4KpR4KqYDrWvvcnzsUDqrXOh
         n/UldMKN1JHQUQtcR8oGMu8ab3XKfh5Z3Ekpk1yrl9yrc3aa9ZxFpyp3nYAkbn0yEUkh
         ywbSZ9Y/ZX0Qw4iUUnlqm7gtV25DRCtd2a8AeHBNLLuTSBEbwB9gEPZxEZTQSzAWD9V8
         WTTg==
X-Forwarded-Encrypted: i=1; AJvYcCX9VnkLMLCyYXekyPufsqa8zGTTrLvj6oeHbqLSxciLn8PamFXYONanGTvjMt3S9f6cg0cVKbuhRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBHyC3tYpOAELUBZ8Re9S4xv/uv1BamVz42ClnOJC9fvwFXu+y
	e38ePwQLOIwhaIiYxvIDNRr5T7jIa0ijg524riwtBaDm0RXpHxHYcYyNH9u30A==
X-Gm-Gg: ASbGncteMmKODzItuDfplPBclhm0b4+hhTsYz1f4GLk5bbmWftXuHJ2jiTcncqDONWK
	8NEAakEoer7iO0TLeYQ+JG1KKcPNuwwhXMlX201VJYMfVOn5S7rkonsiP3Pe5ogBS0FeVIUOUst
	l2GZJy3Zvh4tU5P1KsFV15hO13m9auBAoCDaHsr2nlVR23Bm5+6WQUMRlTub+IKnOXAaEb209m9
	eWDrQcIpxmev5CeDl1A2jq3d5X2ZdC5BFEdAN7023uW
X-Google-Smtp-Source: AGHT+IGheYjz/Tntpw9/GolL/DMsSlt5WgODtQmt2XRXREaZkoneuXtaerczDwb+tPVqlQ7KhsD3lA==
X-Received: by 2002:a17:903:230e:b0:212:b2b:6f1d with SMTP id d9443c01a7336-2129fd23d8amr180049005ad.32.1732503010250;
        Sun, 24 Nov 2024 18:50:10 -0800 (PST)
Received: from google.com ([2401:fa00:1:10:66a3:d18f:544f:227a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc1596esm53695155ad.189.2024.11.24.18.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 18:50:09 -0800 (PST)
Date: Mon, 25 Nov 2024 10:50:06 +0800
From: "Sung-Chi, Li" <lschyi@chromium.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, chrome-platform@lists.linux.dev,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: mfd: cros-ec: add properties for
 thermal cooling cells
Message-ID: <Z0Pl3muZx716QSed@google.com>
References: <20241122-extend_power_limit-v1-0-a3ecd87afa76@chromium.org>
 <20241122-extend_power_limit-v1-2-a3ecd87afa76@chromium.org>
 <4f5sahkxxqb5qonh676igaiadkxv2pbhbibu6wtx4yenplfn4o@yvidi4ujavhr>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f5sahkxxqb5qonh676igaiadkxv2pbhbibu6wtx4yenplfn4o@yvidi4ujavhr>

On Fri, Nov 22, 2024 at 08:49:14AM +0100, Krzysztof Kozlowski wrote:
> On Fri, Nov 22, 2024 at 11:47:22AM +0800, Sung-Chi Li wrote:
> > The cros_ec supports limiting the input current to act as a passive
> > thermal cooling device. Add the property '#cooling-cells' bindings, such
> > that thermal framework can recognize cros_ec as a valid thermal cooling
> > device.
> > 
> > Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> > ---
> >  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > index aac8819bd00b..2b6f098057af 100644
> > --- a/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/google,cros-ec.yaml
> > @@ -96,6 +96,9 @@ properties:
> >    '#gpio-cells':
> >      const: 2
> >  
> > +  '#cooling-cells':
> > +    const: 2
> 
> This is not a cooling device. BTW, your commit msg is somehow circular.
> "Add cooling to make it a cooling device because it will be then cooling
> device."
> 
> Power supply already provides necessary framework for managing charging
> current and temperatures. If this is to stay, you need to explain why
> this is suitable to be considered a thermal zone or system cooling
> device (not power supply or input power cooling).
> 
> Best regards,
> Krzysztof
> 

Thank you, I will rephrase the commit message. The reason to not to use the
managing charging current and temperatures in the power supply framework is
that:

- The EC may not have the thermal sensor value for the charger, and there is no
  protocol for getting the thermal sensor value for the charger (there is
  command for reading thermal sensor values, but there is no specification for
  what sensor index is for the charger, if the charger provides thermal value).
- The managing mechanism only take the charger thermal value into account, and
  I would like to control the current based on the thermal condition of the
  whole device.

I will include these explanation in the following changes.

