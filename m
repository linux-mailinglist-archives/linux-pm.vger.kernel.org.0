Return-Path: <linux-pm+bounces-37295-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FEBAC2B996
	for <lists+linux-pm@lfdr.de>; Mon, 03 Nov 2025 13:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAB2C4E63D8
	for <lists+linux-pm@lfdr.de>; Mon,  3 Nov 2025 12:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BC830AD0F;
	Mon,  3 Nov 2025 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="zC9ft3RB"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D78830ACED
	for <linux-pm@vger.kernel.org>; Mon,  3 Nov 2025 12:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762172235; cv=none; b=DvB8DIMOfVdld2H84hUyFiQ3JNwWBg1x18rS7LRTXh6HBa2xi0UN86uO7mTrGQ3zTF2JA6flwNt7kpJ3CL22fT/Si0nrg+mxmxP4EI8ElsQrD4IpBczMZJoC1Vg8u5dODEbOj0p/SHbX22I3mKeosaJKEVunlRVnljwmV20lZ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762172235; c=relaxed/simple;
	bh=N6dzLqWRKXo3vdjPNtp4WU0RNAGv8JDAOdUXXVowYMU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=foIeBkdA+tCjDJbt1PIrg3jgd/jowjb3M878GRkKWxCOhWXD+nX5Z4S/IcJUrxS2zzcbr1xDvNTBhE7Iro5eTUg3r4ycNfMBuwS8fxWnbtUNK11bLYTI+TRquiGiigZ89qrIaGrOeQQop566lgNVbv2KEm6Vg8oicALQe55FkzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=zC9ft3RB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b71397df721so108409666b.1
        for <linux-pm@vger.kernel.org>; Mon, 03 Nov 2025 04:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1762172232; x=1762777032; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNjT7Aiq5Dh6jiEB8sw52p14qgaFnxeV2nRWidKXfx4=;
        b=zC9ft3RBWag/V+c4hsCUTEoIz0cffEe3V3R2CDajBFXXkVe2pm0bDhvl7lNKRLQIrq
         spwO0fb0gLqktktSW3Mh1iTK/dS6rW582Ewl8JrbaSsAbE0syaRN+BM4SJp0d2g6ZlLq
         2xl+67Dod/VLo51R1ncoCrhoCyaCRxsNbFAlqi0CnOKodq4xLsNlEfAxteq87mULbxPU
         OzIf1wYjaaRE6AXA8Ery/wcNRvedXLjPlxS/Fue98UAVeo91zmq+yjk4bVAFzLufeF01
         WdoES5CFbHlIhtxgm/lAyDMnTYR2zJHlSk4unA+ElbdgpUT9OlSj9GjCQu6AGxZbG15Q
         jMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762172232; x=1762777032;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aNjT7Aiq5Dh6jiEB8sw52p14qgaFnxeV2nRWidKXfx4=;
        b=C5DnlrIEdOLpudmJ5E7UCKftyLFcV4wETkgBJ5zB5HpR3lHK1APQVizB38bOJYup3X
         z1HQGlmAhV8sY3eKyU/culll3Ggn4qxcmEvQybwZJ2Ev/mQfAwenlB+2ChW9Cw9KutzB
         rIFa/DVm+4VyUk9f4SHoKVUdvgZvjtBT9zq0XyXIeaTmf7qDh/AxLRxDijia6mjfdWSH
         r6K2bgMxFEJWJWq//xcSrToYUJEsvGMq5Xm3TeU54XbqxhzQUX/ZDeTYGIwKmzZOxWFe
         G4S2pYdBsxQEce+bZBIvVJhJMXUnFCgh5cf3d3yxWVrNfP97iNj+PeaJyoZCv3sd26J2
         Tdaw==
X-Forwarded-Encrypted: i=1; AJvYcCWno5pa8IyMCGth3BH6DyBP1Bh3nLmebLthkkZpJiX5ncMNSyJNxj0bJ4ilxONNViOhybq650NUtA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZPdwG3oi0BhaRVzBzQl1/yWOUtHJKnGwClaX7i6coxf+KqJFu
	bclRNXMWRm9oCou3nDT7Mkjdl2PahIIzVA1TrOdVC4YRKaufjWBExbxtww8SAzc22Tg=
X-Gm-Gg: ASbGncva9tHhkO3ahaZVZiSRjYJGBQwyZ32sit3bCQrSkeBt2A62FQioz6WcfBaGU6O
	UEeN7ZeoYCPKQtgkBsfMoVpAFm2BMr90SfTztHCXzkVUjP2JxmTEgSREOaus0s2zwbiC/9CFkqH
	TteDTezAlCTW4zJfP83nPxe7vX1wTzOrrfzouvRhOdU0pLv7bNA6bhdijHR9oxO2gf211rL33aA
	VxTUlMhY4Eos4DSrtfuD/vJMeA3MiI0dXpoIfx8ROp5RUMLw6XghHIoEevZXBIG5wu05ytWr0UF
	d/rf+qSymeEXBUNLXe3B5UyBMxfufiLL3BXM1vBXWrISa6rYeJwJUSNBi+8s2IeQGUpZY11rMfK
	4SMz4w+/N03n+NLXOGhOAgDHbIpo1Tkmj+cFiNvaXh6jvXUVdAJIwEtIahHFKQyya6CaU9jXdLg
	hYI0yEOuDB0SA6BPRzthhIAIuWacjiGoz/1MOZ1Zl0RSIdA66yuUFNZDE4
X-Google-Smtp-Source: AGHT+IEKZUv1KyQWAizLeoG+U9udqAbGU47hQIHv4aHNYJKhylIq0YUcjZYxg94xX07JT/Vlq4yG1g==
X-Received: by 2002:a17:906:f5a9:b0:b6d:519f:2389 with SMTP id a640c23a62f3a-b707083253dmr1286167366b.52.1762172231791;
        Mon, 03 Nov 2025 04:17:11 -0800 (PST)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b70bedcec19sm332233966b.7.2025.11.03.04.17.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 04:17:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Nov 2025 13:17:11 +0100
Message-Id: <DDZ1X799V2KV.269J9YL1AGCIF@fairphone.com>
Subject: Re: [PATCH v3 0/7] Various dt-bindings for Milos and The Fairphone
 (Gen. 6) addition
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Manivannan Sadhasivam" <mani@kernel.org>, "Herbert
 Xu" <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>,
 "Vinod Koul" <vkoul@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-crypto@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20250905-sm7635-fp6-initial-v3-0-0117c2eff1b7@fairphone.com>
 <c93afd94-9d94-42fb-a312-df6e26bb2bc8@oss.qualcomm.com>
In-Reply-To: <c93afd94-9d94-42fb-a312-df6e26bb2bc8@oss.qualcomm.com>

On Mon Nov 3, 2025 at 1:14 PM CET, Konrad Dybcio wrote:
> On 9/5/25 12:40 PM, Luca Weiss wrote:
>> Document various bits of the Milos SoC in the dt-bindings, which don't
>> really need any other changes.
>>=20
>> Then we can add the dtsi for the Milos SoC and finally add a dts for
>> the newly announced The Fairphone (Gen. 6) smartphone.
>>=20
>> Dependencies:
>> * The dt-bindings should not have any dependencies on any other patches.
>> * The qcom dts bits depend on most other Milos patchsets I have sent in
>>   conjuction with this one. The exact ones are specified in the b4 deps.
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>
> FWIW this looks good.. where are we with regards to the dependencies?
>
> Are we waiting for anything else than the PMIV0104 (as part of glymur/
> kaanapali)?

Hi,

From my side, I'm not aware of any patches that have any unresolved
comments, so I'm essentially just waiting for the correct maintainers to
pick up the variety of dt-bindings patches in this series, and the
PMIV0104 and PM7550 series.

Any advice to make this actually proceed would be appreciated since most
have been waiting for quite a while.

Regards
Luca

>
> Konrad


