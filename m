Return-Path: <linux-pm+bounces-18326-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA2F9DFD9C
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 10:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDEB3162783
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2024 09:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184311FC117;
	Mon,  2 Dec 2024 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAxikhmM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3CA1FBE9B;
	Mon,  2 Dec 2024 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132892; cv=none; b=RoPHRicLThEdMHOt+4g8SaybAbDIe3qQZ3s4LGLSCEeOYFCPi/fWhCchi1dCp/UFdhSj8BHrFCVE17D4m2WVkrRw101J3V/JPXRDykg8EqV1Np+wl73Lu4HHtujMqbQSqp4ALnK+caTKKsH9wMjWx9YKYvEpOw4BU8mL8ymiKbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132892; c=relaxed/simple;
	bh=XyK6JJc2MS6uiJOZtNGQ77axjfYzo4Aw4iRhr7Njxwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IuS6BFnDV/ssFf3seB/Gad8L1TyZ+1/5WRdV7ZaUkeT/SHjbrqkH1g80C2VgfqfqgWgQpb70e30aGh82Iokccesgs9+IBje6AWvkDg8QT1DXJWCpCbpR+la32etNrdC4G4cKvlT62q00fcg1djNbTOZwOH32YcP1o1TzS1AcTkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mAxikhmM; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso535978066b.1;
        Mon, 02 Dec 2024 01:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733132888; x=1733737688; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IBK4652sYfOKYrGRBYDoSF0xs0OKs34l32mh6irIiV0=;
        b=mAxikhmMLZsfIM4XApoDjNr/F3agy43RPuuHwu1ictlDmoiJOTreseqkkeh14GVAV5
         5j/xm9o76BggmdVceQrBSzKyjMjU7W31FeiOfgI6ZuAlSzpgh1aS5QFAkM1oNEYyiRW2
         taZuqo8814pknToCcMjYwLj94l9oeGujrJACEHgojMY5XkzfA1BnaaX4IfnvC2tEu6ts
         GNNtisWPjzS8PUF7e0rdVIUM70glzExFUzXBZJ0I/25YZUALNU4LqD3E/v7v3C86wHjj
         CR/dR1GISsBr5XOqpB/PIlOdNXMPAEVRa70jL9r/R65sEF+YT0bU9Tv090rSRxc2W8rY
         x/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733132888; x=1733737688;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBK4652sYfOKYrGRBYDoSF0xs0OKs34l32mh6irIiV0=;
        b=wlvqMoSoZrGw6ZyWdvDGkGZjwC0hC199Tu+LW/Luhq60MH31LztzOmDNLJxJeHpxNV
         MR0SrS6fkM0lam4yDbRqrak81vNx7wMo9h9CEXVYghX30CPQ97BBzWdwIP2UghLjnVPT
         wgd1ose6nhiMFy69s4z4U8kitebIhy0xc3ZDE6BtbtNr+hjA/9sWsr6CXqa520/GsvS2
         S9flkUSBRsNzcfEjOYnY+PREk/ponOelDgEsVQALFwoWN6pEQRI08sXk4t669D4ZA6xR
         IB2VjxTYJEu6e6Z1v5YvJjc3gunQgOzqTyc51xLHetouSwA3YZ0HWstxhaJOyqadLzQM
         E6sw==
X-Forwarded-Encrypted: i=1; AJvYcCUctqRf2GZcZKjfydtjNxq8FViB4zfhseU70n4tiF4PnOQbdn8sp+7U0e15pfwz3yQ3xn3iunMw8/pM2qw=@vger.kernel.org, AJvYcCUqWOsJgqqRtfaDawgEt4CyNX52NJBjbrTIByxwInh1SmNLl44dD+PNklsr5+Wf5Pnzg+VdAvkpDTLn4KRw@vger.kernel.org, AJvYcCV0sevSLGUy9s/UfuMqbCm2fFpYmvUWiNkgLISPhl1hWax0nboOcLwsH2Xv54mGA+XM2Jj2rQ4m23+ieA==@vger.kernel.org, AJvYcCXfie/CRJX5A7LC8V+FuSXwYWUNfSuOBGI5jk9FmtIAE4iVElyX2gRL35a2EHNTf94Ut0Cv8BVhRGdb@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg/4uwr0dTiZ0cBcdrguGLuYlh6yvwEWpP+wcFWqXP81C/1yTy
	oIO6afJbRaOWWcJtak8Y1rnsQfs5SvAhHCgB5gCyOXA0f86SFRvg
X-Gm-Gg: ASbGncsDhbNRCJ+lV8o3UVtNjHyzyM0hU4dZ62qPdgDgi8/N963bqN5xSLFlJ78pg9x
	It2oGwGSUuAhiKGMNraRqeaKfYbk5j/hZQdM1ceNOip+oilKpYyaGXfuvH26pkfIpZxYwVZ+tSI
	OPFbFNNcvjdcOC/XGoSUUevXqhYGr12usVrCT430BIWFnVBNKxMc5dBq1nqWcOvm3ow+Lke5iXO
	EgfNVRe5agzt942MalXqIvpzt9S/qrtUMH+RKQCJE5mjxZN
X-Google-Smtp-Source: AGHT+IGmVmWnm03Dt1T8R8SwyI/C3c1z+toD+fGD7aWYOwRJfXrS88BoIGjsfBRUVpTXtJBSEXjmHg==
X-Received: by 2002:a17:906:30ce:b0:aa5:1551:99f2 with SMTP id a640c23a62f3a-aa581072b9amr2017019166b.49.1733132888427;
        Mon, 02 Dec 2024 01:48:08 -0800 (PST)
Received: from [127.0.1.1] ([46.53.242.72])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aa599957594sm487059766b.197.2024.12.02.01.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:48:08 -0800 (PST)
From: Dzmitry Sankouski <dsankouski@gmail.com>
Date: Mon, 02 Dec 2024 12:47:56 +0300
Subject: [PATCH v9 3/9] dt-bindings: power: supply: max17042: remove reg
 from required
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-starqltechn_integration_upstream-v9-3-a1adc3bae2b8@gmail.com>
References: <20241202-starqltechn_integration_upstream-v9-0-a1adc3bae2b8@gmail.com>
In-Reply-To: <20241202-starqltechn_integration_upstream-v9-0-a1adc3bae2b8@gmail.com>
To: Sebastian Reichel <sre@kernel.org>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>, 
 Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-leds@vger.kernel.org, Dzmitry Sankouski <dsankouski@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733132883; l=781;
 i=dsankouski@gmail.com; s=20240619; h=from:subject:message-id;
 bh=XyK6JJc2MS6uiJOZtNGQ77axjfYzo4Aw4iRhr7Njxwg=;
 b=dpX46eSH3O/jrTANusO9pbo8WAQDdhPlIhEVa9ReT6HLZCxAo3qxm6BJ1bUiE2klW2swf+ZG1
 PYBqoYOLmgeDn5ucxFIloqxHVTqSsmyyXXMmtOGO/6TEPjDiNJlvmoz
X-Developer-Key: i=dsankouski@gmail.com; a=ed25519;
 pk=YJcXFcN1EWrzBYuiE2yi5Mn6WLn6L1H71J+f7X8fMag=

Remove 'reg' property from required list, because in platform
variant it should not be present, because i2c client is passed
from MFD driver.

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
---
 Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
index f929e7e2b82a..7a26036a8890 100644
--- a/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
+++ b/Documentation/devicetree/bindings/power/supply/maxim,max17042.yaml
@@ -64,7 +64,6 @@ properties:
 
 required:
   - compatible
-  - reg
 
 additionalProperties: false
 

-- 
2.39.5


