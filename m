Return-Path: <linux-pm+bounces-32642-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A7EB2C5A9
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 15:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 918C07A9002
	for <lists+linux-pm@lfdr.de>; Tue, 19 Aug 2025 13:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6EE7340D85;
	Tue, 19 Aug 2025 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nK/g15QG"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8359E33EB0D;
	Tue, 19 Aug 2025 13:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755610327; cv=none; b=afA8TFs6WbYnJepXeI2xOGZYyn0tknrQaH4FIQaYV3bTv9D2oAvZaGHN6/IuU2MZMxOPEtoibjgsAu/CI3n3ZZOBqjy4mpR1vbUSBhjxtaQUsDhh8HAHqJr7F+GyZ+3V6bpP5mifsIQWxjaBRO7w64XgfEQcWsvO0jE3roLRyTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755610327; c=relaxed/simple;
	bh=RePw/qN/r8iFmlUKhdNcuusjorcaH7BDzwljb0R672g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGV5kYdNlK06Ap2RR2HwiQPCkzVRKPSlspEU35km66m/9jVg9GhnDgoBcVcWzrwrVLtmO8NYlix5fGFy54E3ZQR7YYmrC2vJ6ABpPn7l9hPA/uDEUDiU/uJ8e79SRJAU4p+SUn72z5YQEb4WugCli7of5DJNGnP8BvRTdeRN+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nK/g15QG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15FA8C113D0;
	Tue, 19 Aug 2025 13:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755610326;
	bh=RePw/qN/r8iFmlUKhdNcuusjorcaH7BDzwljb0R672g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nK/g15QGjqargMMW7pQ66890hApkyy9hXyKHZ9Cg52oUi04dvT7KAW8rJgFXJd9BG
	 g7VfXVoJLowIrw9KXnB93vr/XByweloc3thrvk7hERlNII8l1j15ZDdD5qBxHlCAnS
	 vpPA5Vhcvv7IWFeND02BBcagEHa0u1dzosBIknBE7fLMvJJj6e8h39hKOFJVnzYwTX
	 8ZDwMGguCQx97dLYSQGIIi+9ZKpH175hDsPIbk7uSixbT2CRWZfs87MvWE95PusWKJ
	 tvo0Vr7xO3U37pIXTfYbbp9tTwyG2HwtvqwQI+0Mmw8lIaEH4DoEqSIi/gUWK8P+Ub
	 hcBlb6oFPgNbg==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afca41c7d7fso1071405966b.1;
        Tue, 19 Aug 2025 06:32:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUWRfXpFKPnWrqpAyTxW6X0AzRkE7slNq3EYjWQ8epHxqxbD1qwZHTVUls8HBa5X40+hmHHFFj+JkR+C7tm@vger.kernel.org, AJvYcCUtCL9m73SuoQ8eK6i627akdRhYEjKUCsTXRFxQhMf0c2+wuNdA75JKqdHuM81+XBckSR2mP2iaV+ab@vger.kernel.org, AJvYcCWXyDHptwJWFhOmBGfrmlKeg3hyblecmaYv5CYKVk0E09M+wy7+9BaOWYJh1uK9X03sMrQqCSLKWwQ=@vger.kernel.org, AJvYcCWjJuQJsdYpTgLFetRou+CpPTHg0bxEBzINLoYIocO8WW5gd1tOp5kg2RkJ3N9AcMIzHXh9qRFeqdZgAPaiNw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd78ljIn8SfvzWGaKQacDWKE5lOqsTN2wQy+pZV4wU96wnlJUd
	pb7/bbaNzJSh10wTyYYz+0gLCyy+pSxOx2/UXlSVcmPmJ8PWNhn9C8U77lQD+7hXe0bdlbMZ6FT
	fDzAJ+RaBjx3kvlI/UMA47JNpJVczhA==
X-Google-Smtp-Source: AGHT+IH7Xlxz6mfCkPT5meOPBk+lpt++QuBnzbYmHx95kt43nBgRPDjtSqtV4+eqSIu0C0Vj32Von41lElLYRUtx6d8=
X-Received: by 2002:a17:907:86a0:b0:af7:fd29:c5e4 with SMTP id
 a640c23a62f3a-afddebca776mr278602866b.2.1755610324732; Tue, 19 Aug 2025
 06:32:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814-glymur-icc-v2-0-596cca6b6015@oss.qualcomm.com> <20250814-glymur-icc-v2-1-596cca6b6015@oss.qualcomm.com>
In-Reply-To: <20250814-glymur-icc-v2-1-596cca6b6015@oss.qualcomm.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 19 Aug 2025 08:31:53 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL+C1VueQjrKra8fNTd-2k=gkoy-jA9uuQOhuyRMbQroQ@mail.gmail.com>
X-Gm-Features: Ac12FXwcbhYarWG96-RFlBPTciYD1YIKgoRxrJwgNxPiK-pCah48gmfFg2yv4u4
Message-ID: <CAL_JsqL+C1VueQjrKra8fNTd-2k=gkoy-jA9uuQOhuyRMbQroQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: interconnect: document the RPMh
 Network-On-Chip interconnect in Glymur SoC
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>, 
	Georgi Djakov <djakov@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Mike Tipton <mike.tipton@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 9:54=E2=80=AFAM Raviteja Laggyshetty
<raviteja.laggyshetty@oss.qualcomm.com> wrote:
>
> Document the RPMh Network-On-Chip Interconnect in Glymur platform.
>
> Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.co=
m>
> ---
>  .../bindings/interconnect/qcom,glymur-rpmh.yaml    | 172 +++++++++++++++=
++
>  .../dt-bindings/interconnect/qcom,glymur-rpmh.h    | 205 +++++++++++++++=
++++++
>  2 files changed, 377 insertions(+)

This is breaking linux-next "make dt_binding_check". Looks like the
clock header dependency in the example is not applied. Please drop
this until the dependency is there.

Rob

