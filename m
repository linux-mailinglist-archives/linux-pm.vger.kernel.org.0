Return-Path: <linux-pm+bounces-12764-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8005195BEA5
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 21:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364D91F23E6C
	for <lists+linux-pm@lfdr.de>; Thu, 22 Aug 2024 19:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A409F1CCB2B;
	Thu, 22 Aug 2024 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUwwgfam"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D4C13D8B2;
	Thu, 22 Aug 2024 19:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724353550; cv=none; b=YJpvrPmj7u+P7vEz/xmET+Q/Uu+dcx82rcCDPzmepaZxNlSOz+OTiuiQh3lj8E4Na/TC80JD7Iic0kGRD7f0s2IEuDzj8XjuWtUR1G4TdR/OKZppQo6PrSYVqcUGkuk9mPmebXGZ7zWTV6trxCtttm50qUDokEQALdRlwjnHqM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724353550; c=relaxed/simple;
	bh=8kmKkdKB+bP/XDJ3bbKnBGeMf6mSdYD+LNXsB5C09D8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ymoo2KNNvu2vHR2y1GIs85yF4PmulAxBYgUUmWSIwopHNeUGY3lq0/knrP02hB4/jN4ic5eoZgGRWYyKF2Lua2XPXxss6ThZRmVwOd8aTN3r79U+pCC6qgMFGfsAbKEtgjn46EX1Faux0hZtaGFDVqt0svA2IeHrWkifQ+vJKPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUwwgfam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13059C4AF0F;
	Thu, 22 Aug 2024 19:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724353550;
	bh=8kmKkdKB+bP/XDJ3bbKnBGeMf6mSdYD+LNXsB5C09D8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qUwwgfamPVYfMtqESx6bSCybae1p5QmsQGWag8+PozaZIcwOywAiByfblKAXno8nC
	 IRd+HPOsNQjnkHiHyY6BrUqwibP0RMKw3EpVAjrUS2Xnm1GJGJLW0Bq7gaCI2GkPuF
	 JIcfyiDZtBkVbGH8q1StiL3Vxlp35VtBkGRRCwjSsCpb1ybposUxNfm8wkX601/hZw
	 pPJTz5Hs1jf2H/58PLzuASTAcpWj1+NIHmZZNqM9SoUoeZRikMG9Msq8aZOhSQCnaT
	 O4UpagMJxZZzpfijE/Z4t21dmCdHhsRr4JejyrNBLNwuN0OwjJGNAcettjuhT3+sUL
	 R3ZM7qDTJZtvg==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-270263932d5so831683fac.2;
        Thu, 22 Aug 2024 12:05:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUPoRSMfxVJqWLJ2pyxlgvkuhwt4iLH7w4AbiL1hTDL+byiChaXmbAUCWQl0PNu1f1FZg7TWku6@vger.kernel.org, AJvYcCUQiZ+1XvjItpB/ln3WfiQF52HGsAKCnpXmmfdArv1tPk0mbg2hur4QyLuAryK2TN8IqZVZ1BTNiMwOCv8=@vger.kernel.org, AJvYcCVAebGK46my0QF9TAf/K7iwiy0EN0GIYRGTTXmXlWrJjIhKR0ltswBl0TylXVAGjS1mNWUEZbJ8amE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/LquK70AO8oP0yPTOX7cCnih/jxBMLPjKLfI2Sdmqf/FsHi39
	ozdrP0FbHbohLrzy+lPqfVZIHtETYHkUEv8ORP2wEFrzqiWLk0Tq1XbzHXEsc2t7aLmZ0f1Y8ys
	dOvCcmaiqM4QC7MCnXYQS9TQiEug=
X-Google-Smtp-Source: AGHT+IGsx9MlDIqyZirN99gmnxGl5XE4O19AIzi2CakpohYGGZpr+FqqWk/yIZ1gsBeMm0skdNnTRtffCrhYTx9fNIk=
X-Received: by 2002:a05:6870:d10d:b0:260:fdd5:4147 with SMTP id
 586e51a60fabf-273cfc55bdemr3593483fac.15.1724353549379; Thu, 22 Aug 2024
 12:05:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
 <20240814195823.437597-3-krzysztof.kozlowski@linaro.org> <fcee1000-9f8d-40c6-8974-06e3c1722645@linaro.org>
In-Reply-To: <fcee1000-9f8d-40c6-8974-06e3c1722645@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Aug 2024 21:05:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hMLVGpw+Mrso=6kpL+wMn=6UCrCykGk7nG55uidfkrAw@mail.gmail.com>
Message-ID: <CAJZ5v0hMLVGpw+Mrso=6kpL+wMn=6UCrCykGk7nG55uidfkrAw@mail.gmail.com>
Subject: Re: [PATCH 3/3] thermal: of: Fix OF node leak in of_thermal_zone_find()
 error paths
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2024 at 6:12=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 14/08/2024 21:58, Krzysztof Kozlowski wrote:
> > Terminating for_each_available_child_of_node() loop requires dropping O=
F
> > node reference, so bailing out on errors misses this.  Solve the OF nod=
e
> > reference leak with scoped for_each_available_child_of_node_scoped().
> >
> > Fixes: 3fd6d6e2b4e8 ("thermal/of: Rework the thermal device tree initia=
lization")
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Applied along with the rest of the series as fixes for 6.11-rc, thanks!

