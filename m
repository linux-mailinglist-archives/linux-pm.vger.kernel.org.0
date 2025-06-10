Return-Path: <linux-pm+bounces-28364-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99569AD362B
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 14:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 632FD3A42AE
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 12:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713BE2918E3;
	Tue, 10 Jun 2025 12:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LKRL/wkh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A18B2918C8
	for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749558524; cv=none; b=qepiDoAj9raQgyqb+F0YOnrtP3POj9S5pci3D/HlOTqKpkGqZZ97AbAq0hnKeRDowKmYBInYBD1zv5TI3zJf6qlUdk6XBQrurQvziAs9kVXk3AAyVU3Rd+pnGF9Vnyvthe58caLkyr+CO1fFhi8lFrUqff1fZTP6Wv+3CLqzVlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749558524; c=relaxed/simple;
	bh=qpvt2l7UUTiMSp9Nt2nHtj3uisD8+uoR1/1D3UNyhR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJDC9F9v//wuYYgVFC8HRg7Ma/lqNBy3HUZBDOZ92JMSDZXsTCzmWB1/s47Sefx5yRelxYJxDZvprWzEli52RjJh3TNnMi+g5Jf0urP72ycL+ZFLel/pJKd8kiNd/6SYiRdVvNrHOGqMWbyZHDW8c3GL2u7Bcki8UdgJUYY9Hvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LKRL/wkh; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55324062ea8so7011763e87.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Jun 2025 05:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749558521; x=1750163321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GsOrVxtqepjy8J80Lyog9ns9pzcfAzcmyvDrXuJUtgY=;
        b=LKRL/wkht4QnbzCRHU/vBDVUMjED1jaa0jjtHJvHAlutsaNYecC4eFasiWryepV/ll
         Y+x6UvmsgzLDvOy63wAExi66zcdfI4UprmZHRjrCTCJ/NnR6BnF00ZdbNmmHRBfHVYO9
         lWLg9r8eTokbfiRRDSvEtZYWuMy7aHJo7eRcD7SjlZdfPA44U5FxPAfJ93xS8n1BYKcy
         6auYsn14kfIvYNwArTOr/uYnz0/wScCoxMyRnaHEzg3ptihTotOJsyhwdS+bK4JQXH1m
         0NrHWXJKb+ErGqTlxIMavAM8R9dzm575lfhqDHPiUGwPrj6dSeEkdfYRjxH9sbW7ZVzJ
         SQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749558521; x=1750163321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GsOrVxtqepjy8J80Lyog9ns9pzcfAzcmyvDrXuJUtgY=;
        b=Ek8kfzbmbyVjuAapwsZJSjPay1JzyqIlpU2bS7GrF3PWw6K3zgWKku6WH63V3OGBMV
         23GtFFi+M4rr9dqtbwcDa1wz+eKCKNxZ0p+etNakyjSAcv6vp5sB4r13ov3Y9WhNjUc1
         w52X5iSSr2/+bJu3lSDXbaAfQyXWNalT6gz41q5YQiGyN5FJTLdZGwT76HPDJ5wqm5K/
         Oz6Upe0d9QKxo/6cHf4z5kSmx6jXG4jBJfgoFO/6v9fL7x0J1NkEuEnAmmEAitY1oXPy
         oZqwCsjBI2U096MHIkuMe1cAId/Cb44VliZhcSR+HCp4/p6+ElQHy8x54242fjj1bmEK
         fSsg==
X-Forwarded-Encrypted: i=1; AJvYcCU3tOO0bCJCEGz7zhj3ORCMkSQ0XtbfGPVc64gFZ355YA2PCY144cL1E5rGXJx2/zzEOU7PA/TlVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxun0qmLZ0j4ORLyXm8psh01KtK50zAUCjt8kajA0EyK2rgdYGf
	3FUAUbmQzWKdAnQQq59M19pUedJtX0ll1dvt+WT6XQo75Lo0k9kboLW1LKjEpcTAAXxGmcPztY2
	Adn9Tnu9y+RRCsW93+P6YksO1vvW/eu9/1PUmj986zA==
X-Gm-Gg: ASbGnctUXPPdpZ4o2We0OnGeESUQIE0m+v/R0WlyxtCbKv3RWwEVuXGetkgT+uhms0W
	Rl+OsXYDJ9SZlbazFo06rGfcua9gP0re8GGggeMYXlRgyfcUW3//gmctGqPxlIIBnyQ/QHchwwT
	GOJ9xdsVLOsk+QsOYVTbWhkMMGbYEZbIXPU4HeYpkWGnM=
X-Google-Smtp-Source: AGHT+IGIP7rndrIqf6RWqLJPp4xdoAE+TRSEB9XlMrQhxRf3kV/JruNVdV2IPEdtEosg+5E6PSBoZ/3/v3lz/smQsyE=
X-Received: by 2002:a2e:a595:0:b0:32a:651c:9af9 with SMTP id
 38308e7fff4ca-32adfd5e7b1mr45162751fa.37.1749558520672; Tue, 10 Jun 2025
 05:28:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604-dt-bindings-psy-monitored-battery-v1-0-7f755ff75218@linaro.org>
 <20250604-dt-bindings-psy-monitored-battery-v1-6-7f755ff75218@linaro.org>
In-Reply-To: <20250604-dt-bindings-psy-monitored-battery-v1-6-7f755ff75218@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 10 Jun 2025 14:28:28 +0200
X-Gm-Features: AX0GCFs14D3DfdKPGW1oWe6McnWZU01oPtzxcnEFGOdPnt5cB-b18SjhfOGEaq0
Message-ID: <CACRpkdbMFZmK3oUapXDrJjtfhBn56shGu9uoFYPT2_HesTF+Xg@mail.gmail.com>
Subject: Re: [PATCH 6/6] dt-bindings: power: supply: Drop redundant
 monitored-battery ref
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
	Casey Connolly <casey.connolly@linaro.org>, Jakob Hauser <jahau@rocketmail.com>, 
	David Heidelberg <david@ixit.cz>, Dmitry Osipenko <digetx@gmail.com>, 
	Tobias Schrammm <t.schramm@manjaro.org>, Chen-Yu Tsai <wens@csie.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 10:19=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Bindings reference the common power supply schema, which already defines
> the type (ref) for "monitored-battery" property.  Drop the redundant ref
> from individual device schemas along with obvious description also
> duplicating what is in power-supply.yaml.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

