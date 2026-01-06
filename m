Return-Path: <linux-pm+bounces-40265-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A38B1CF7002
	for <lists+linux-pm@lfdr.de>; Tue, 06 Jan 2026 08:14:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A65B33062B3E
	for <lists+linux-pm@lfdr.de>; Tue,  6 Jan 2026 07:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFBA309EE5;
	Tue,  6 Jan 2026 07:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PNZS47N9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCB02C0307
	for <linux-pm@vger.kernel.org>; Tue,  6 Jan 2026 07:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767683546; cv=none; b=eYyG/1p4Y9Z/Qy8uNiKrmK1Hy5uW7eodAeMoBS70Ejohbp5Kf0i3bVC/cg/+yj0wxK1KexCckMJ2hBYQzzaebE4OKxFkDVy7LDIojtOwsYFwuYUy8NCBK3De/Rw0+2kuQF6uZTtAkqRGzGgz3NBrGjNAuc4/HkJSKfz2NGlfwNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767683546; c=relaxed/simple;
	bh=Cw6Vxv2UdtRGgdECy+/fqJVP/fOdAd5jem9BgKrHC3g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XhF6n0N/wAZ1RtyRIDafYv5VO0AL5baw2ldTQvQayH6Dgd1ezJFKY5MWbKKFCcbX5m4d/nNO8HKinQs79apuUMETcsKElx9nyGjJrxWzy0CYuv19xBOuXcdD18YohHXlCKQSToEvXIswftw6U/Ue/i/rpUhV8Q7+2zgwUk1fD8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PNZS47N9; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a0d5c365ceso8452365ad.3
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2026 23:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767683544; x=1768288344; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cw6Vxv2UdtRGgdECy+/fqJVP/fOdAd5jem9BgKrHC3g=;
        b=PNZS47N95qBfEc6EjVqicmj+oZk7lwIJqhfYRQyk0z7k146uwnWKw4d/MwVDioDpt2
         FOhdyBJTnytY2eCWiLS3WIluKx3aSBksQc320ZoVRckXkrwu2di4Uy5iZ91xx3P87kBp
         FvsnonWn3rSjbomglAstUO2CzYENTSZs4Wo7KrkvxtpMWyO37rid/H0pFOGuXv5GYWX1
         xiA00DiVrpFk0IrSdg/Yc+ox+fdsX9afLXFw5VPe66rQlepJUIaSeOXzgR8GR69dxpL9
         00zbf9Fk9umrq9gbrbHLDRbN8209zdMXi7mvRVyaCltyLD+2OBagmo7SKhnFio5CRb6b
         WOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767683544; x=1768288344;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cw6Vxv2UdtRGgdECy+/fqJVP/fOdAd5jem9BgKrHC3g=;
        b=n655W83zhi8ty8aDaSlbW5v/eRetFhkUVMKXw4q48HpWGZwzHzaTcKOS/aKprNA5X1
         mG1dx6bzeD9/shsEPfjXVQdykWzSZOvrjXU3h6WgIcpv2lK7vjQwg0mvEF4NPX0oVMtM
         6kXZPyxvbvDruERF0IxGYo7EcyoepkEUDXmqkKTVFUIn/X2VwL2Fak5qvfBVjHCwy43L
         xAYUxDwxB7scDmfdlNiXj9bQqEw6QMWb9u6Cp5Ae28D1TxSY5yb95JkFCXItnwlsxyrv
         kjHsLJXwAtE3WhFJAKnwmDj7geLlNIYPoAZXo9biEXVQew3AMuGPCxqAjfL4brOAtn4y
         MefA==
X-Forwarded-Encrypted: i=1; AJvYcCVaZZlPJ37f27ieoZnjtgmVtiuPK5WBoeYTAEgoNfJoZLLfCetc7bjwt8G3HGAQ5wEY7wlh3fcZVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbLe3rEyGhTxIXY6aIp9MQT0yhG6kONHIz9Xj+Ul0hRmHq5jB7
	YZWVshYowlXdqBwhSZakHK4tUYG7MAQvwyKJIJt90GtN6pM1+Da8g2p4H0cZrpHyJoQ=
X-Gm-Gg: AY/fxX6Eg6VS21Hgbs2T2kdyf7ZDtgsFXkiJOd1QwbCxpzbpFCKy1WVTcP4aHb7ETr6
	jfxFgyj5aSFbY8YzWxaVjpmwiKWd5yshbqrNlQEHu3pGUMDew6n2pqL8RXig+Bovru7+kCQTHg9
	ZbtWB+eD13MtYP//8kIfeHaOp8ZklKwrHb/RX8cJOP/iCGCBCGWUV08YL7Cnx4LvHxlBM0rBkNk
	XoLQpsQF7FXzESvYPBU979bzhoofdHGZQziwixIrfYNfUzGDAUihSrD5CjDZ433dBNS0odc9+bB
	3FpBdO2IOBE2UK3hQjPpMCuc+sgykl9ByAkiCqcHI50C5VfPSghJjUVg58DxmZpAfS9at8iW0ES
	UfdPl58WnqitFyx3uSqN23cVuJMQN5u48APoOBQ96d3zL/tjKNsKBYVp47oueznUKVqm8A1DFYo
	GZDi5RMEoK5bIhGQhaaw==
X-Google-Smtp-Source: AGHT+IEC7hkB8a3+W+9CynY8VbKDMio9JBatwLTf/u7tQYOQk3WKz9MPs9tq00X2Puv0ME4y4fl2oA==
X-Received: by 2002:a17:902:d491:b0:29f:b3e5:5186 with SMTP id d9443c01a7336-2a3e2d569b1mr18844285ad.56.1767683544446;
        Mon, 05 Jan 2026 23:12:24 -0800 (PST)
Received: from draszik.lan ([212.129.74.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cd4401sm12261165ad.92.2026.01.05.23.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 23:12:24 -0800 (PST)
Message-ID: <8385a4fbb6c10cfe643c2f310f6a67150e260cf4.camel@linaro.org>
Subject: Re: [PATCH v6 0/2] MAX77759 Fuel Gauge driver support
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: t.antoine@uclouvain.be
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Peter Griffin	 <peter.griffin@linaro.org>, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Date: Tue, 06 Jan 2026 07:12:52 +0000
In-Reply-To: <20250915-b4-gs101_max77759_fg-v6-0-31d08581500f@uclouvain.be>
References: <20250915-b4-gs101_max77759_fg-v6-0-31d08581500f@uclouvain.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+build3 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Thomas,

On Mon, 2025-09-15 at 12:14 +0200, Thomas Antoine via B4 Relay wrote:
> The gs101-oriole (Google Pixel 6) and gs101-raven (Google Pixel 6 Pro)
> have a Maxim MAX77759 which provides a fuel gauge functionality based
> on the MAX M5 fuel gauge.
>=20
> Add a driver for the fuel gauge of the Maxim MAX77759 based on the
> one for the Maxim MAX1720x which also uses the MAX M5 fuel gauge.
>=20
> A future patch will add both gs101-oriole and gs101-raven as clients.
>=20
> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>

Are you still working on this? Are you planning to send out a new version?

Kind Regards,
Andre'

