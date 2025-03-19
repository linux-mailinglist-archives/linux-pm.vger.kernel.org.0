Return-Path: <linux-pm+bounces-24271-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB14A6849B
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 06:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20043BC0D6
	for <lists+linux-pm@lfdr.de>; Wed, 19 Mar 2025 05:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4414F20C488;
	Wed, 19 Mar 2025 05:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdC9LqUV"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508FB130A73
	for <linux-pm@vger.kernel.org>; Wed, 19 Mar 2025 05:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742362511; cv=none; b=ity5G0AKtq8B28okI3kieMNfcnqQ/J9I/qc+8L9J/5prCbF+lk9UoqamlR/Deavoj5ZglNGy8GCIQBSWNJYaiXWRA3rxzyOCCZiym9QQJPt3ibtIRuHsY6OOYFIQe7pce+6whXAPps8oVZO4JE0tF5uIYmAbAwrEUGIx+KMULQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742362511; c=relaxed/simple;
	bh=BJqc2V4r6FqOy56nnp0RIfpnpHABd9NTrRkrL3bqP0o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qpw612JeEGZ/Uix2n6ViOwZL76gqHUGVC87GI4GsZIA39YPwrqnedM8fGLqbZXCt1PWXcGYHsCXeiEkiDOgnBj5PcsoW3E+/bjcGTjVnMFslSAGQ9pw1M6ekJpOdxQTbd8FrxfA6KxElcqXUeKFlgnEBljJIyCJwgx802ik6tAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jdC9LqUV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so27737025e9.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Mar 2025 22:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742362507; x=1742967307; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BJqc2V4r6FqOy56nnp0RIfpnpHABd9NTrRkrL3bqP0o=;
        b=jdC9LqUVZrBJwSgXWzXWHyON+TwBUdI+F0w4DVTBXnHvko8786qrD1kbEzmHR9qrCo
         PduBpHWUzxLJSw4CM/Dkc4C/ME2bI81WFOdQcKFLix6GqOsMJqoHZhw2qRPvW1CxC5zm
         khk67HCGkxKI291ZVAfaHWnHz8uRlZIaaoon0dBRS8UTNWvPgNb6pPqEafG930P3Skjw
         l3yVWExtHs29F6VsYwNbPDhX/wClYz0/t9IRSyR2RlILevJ8YZmroDaY5kTM1nbWcAU7
         7/5tJIqn6Qqx4X4KUgbjSYC4knuyPf65YDvD+Fad+72om4qa1EuBOrOkHcJMUizOUA+T
         OdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742362507; x=1742967307;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJqc2V4r6FqOy56nnp0RIfpnpHABd9NTrRkrL3bqP0o=;
        b=XJCUpVoX9FbuE9zuPzooltKU88Jqyh5QtubU5rFca6RO8qtdRE0w+9hUEdYQfYNWKQ
         2dzFA3eGOrp6cL12gEAcAPWO2DSZsxSrUiCfX2Q/67a+BLZztkouXgIJ+xy4tzklolU+
         PDobRRo1tKfPG8oyz1p9QNbjVkBwhHEDYioLMEkEtE9/XO+D4288KlH49/FtRTYQIiSj
         8oTBt22BtJdORdM+pwJpRaIwIu0ZXVy18LmkgGqy/5wZcU20iPx8F89iBnqqBAJjqObD
         el/qSH85btKDh3Z0hFHc7ayszhcpFQ8BDQ6MHySGvLneYVQl2UkwQ0OOcPcrcuBuIRAP
         +SFA==
X-Forwarded-Encrypted: i=1; AJvYcCW0oKN4INfwtbf0VTeI05uKa9fFDzZaZBtYuFxlUlCXG0CDdXyKR7S3K/xPXBd1AO7pMdUP7vwCvA==@vger.kernel.org
X-Gm-Message-State: AOJu0YztRKk0Aj8NB7pnmCsIxUCFTGBK2plLTQAIDO63QvI2ja/yHE+G
	pdyrUX5xYEepxKjPc47ARUUZ6S6Y3O8d0gWWKcNMzGHmwaqpFohVT4RR5W3Ui7UWl1NBQlG0Ppv
	X
X-Gm-Gg: ASbGncvy3LLap0xjaUrpIJtBPK5j3PEM4z+qcZy6x6QZdWNcwz11uAQjWmxgNCPlMqs
	2NpUc9lDIjxp/3yaYMn55JyJITXsZ5Oaz6ry3sK4dcuDojZpEoXLB9ct41IZ7bF0OXIJL/n6qbU
	fNUgarrfK6xPdq7hhQf2JtV+DOj21US7rSnKnfSqbKqs566XD3VBSSesWKvV3lzTjqZ49n9y+iJ
	faQHsYTieCzLNe9iTOB3GWt18KC/X+W5jpMJWf6bAngTt5IDTvqlSvGzcoMISIDRYuCcvDMGDPF
	2sLaYZ62jiJfOVRDvQfDwU4vuCWAOVMzCF2S5nGTCOORq3Qliw==
X-Google-Smtp-Source: AGHT+IFEhSoQ/DQEODNld9+47I3jsF4TAZ+I7PfGqqGTO6NCSHxQ1Hg/oJ8JzcAfC5cy6PlHPs8sDA==
X-Received: by 2002:a05:6000:1888:b0:391:2e97:5788 with SMTP id ffacd0b85a97d-39973b725b6mr1281339f8f.55.1742362507353;
        Tue, 18 Mar 2025 22:35:07 -0700 (PDT)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f6befesm7891435e9.25.2025.03.18.22.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 22:35:06 -0700 (PDT)
Message-ID: <4f928b89586aa836ad3a905db740fdb5d9545b81.camel@linaro.org>
Subject: Re: [PATCH] power: reset: reboot-mode: better compatibility with DT
 (replace ' ,/')
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus	
 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
	kernel-team@android.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 19 Mar 2025 05:35:05 +0000
In-Reply-To: <20250307-reboot-mode-chars-v1-1-d83ff95da524@linaro.org>
References: <20250307-reboot-mode-chars-v1-1-d83ff95da524@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.53.2-1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Fri, 2025-03-07 at 07:50 +0000, Andr=C3=A9 Draszik wrote:
> This driver's purpose is to parse boot modes described in DT, via key
> (node name) / value pairs, and to match them to a reboot mode requested
> by the kernel. Unfortunately, DT node names can not contain certain
> characters, like space ' ' or comma ',' or slash '/', while the
> requested reboot mode may.
>=20
> This is a problem because it makes it impossible to match reboot modes
> containing any of those characters.
>=20
> For example, this makes it impossible to communicate DM verity errors
> to the boot loader - DM verity errors trigger a reboot with mode
> "dm-verity device corrupted" in drivers/md/dm-verity-target.c and
> devices typically have to take action in that case [1]. Changing this
> string itself is not feasible, see e.g. discussion in [2], but would
> also just cover this one case.
>=20
> Another example is Android, which may use comma in the reboot mode
> string, e.g. as "shutdown,thermal" in [3].
>=20
> The kernel also shouldn't prescribe what characters are allowed inside
> the boot mode string for a user to set. It hasn't done this so far, and
> introducing such a restriction would be an interface break and
> arbitrarily enforce a random new policy.
>=20
> Therefore, update this driver to do another round of string matching,
> after replacing the common characters mentioned above with dash '-', if
> a match hasn't been found without doing said replacement.
> This now allows us to have DT entries of e.g.:
>=20
> =C2=A0=C2=A0=C2=A0 mode-dm-verity-device-corrupted =3D <...>
>=20
> and so on.

Friendly ping. Any thoughts on this?



Cheers,
Andre'


