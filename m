Return-Path: <linux-pm+bounces-38729-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8ADDC8AFE6
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 17:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A4483A87B2
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 16:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347E733DED6;
	Wed, 26 Nov 2025 16:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joelselvaraj.com header.i=@joelselvaraj.com header.b="U9SIJXdA"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-07.mail-europe.com (mail-0701.mail-europe.com [51.83.17.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB17224AEF;
	Wed, 26 Nov 2025 16:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.17.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174933; cv=none; b=uM1X4/gOwfgNVO7ArQAcYdInDmfmNbT/9ajHV1Cz5ofeamTIkHutPRQmTUB/GHFEbsYGknXgE1w1iEauIE+g2XsfgE6wk8qpUXe8uvQWFuqYOSLmyB1ALH36NNqPafWd9/ehmSlRMG8IEYQT0VHz9NLhvoe14aopQnpqg4E8MQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174933; c=relaxed/simple;
	bh=SPv2rlv4694kWserr515m5X22R0OFJNAUVWfTpVF1IM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AZVwbFd4Dy+xwHmQduJIooHAUA6L6VVJAJSSARzZFWWc3hAeByKHQZu88nvdDBeXg5sp8DvQ3R8pvdOXW1gdjRHcPQ4zZ0890XoEuXKi1zXBlb7GKVILABrJuKPNXRs8xSe6YDhKKXZoZRpn15D/twd0gVH/MAqBOAmlOq2+IrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=joelselvaraj.com; spf=fail smtp.mailfrom=joelselvaraj.com; dkim=pass (2048-bit key) header.d=joelselvaraj.com header.i=@joelselvaraj.com header.b=U9SIJXdA; arc=none smtp.client-ip=51.83.17.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=joelselvaraj.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=joelselvaraj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=joelselvaraj.com;
	s=protonmail3; t=1764174916; x=1764434116;
	bh=SPv2rlv4694kWserr515m5X22R0OFJNAUVWfTpVF1IM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=U9SIJXdAd0u0p+XalHk4dLT9rQeuQmwG6ft+2t7aYNadeUweccPZlIABqKwLwevsK
	 GViSkTctW++QeskucLKmgAo2AlrFOOVUQdmEqG82XBDv5bIMpb/8a9Kex1PirdihI3
	 0CQ0IFPG7A2xyMsUx0QngEg74Fq+ZJpCfg6wSCJw/odWe16FTGJVzvQfjzJZvIn7Rv
	 XplUG6S+vceTU03gHUy+hf56Y2rmVS8x5kVT4pyJkGcOeHO2kQ5V8eQNIgtheRAaYy
	 Q+NUyS4y3Yw6El+vgCVJFeL/ULf3GE7TdNHWETLKrGufidcg6+9I8jieU5YEoSAzbR
	 1QUUAcgUdEwkw==
Date: Wed, 26 Nov 2025 16:35:09 +0000
To: david@ixit.cz
From: Joel Selvaraj <foss@joelselvaraj.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Casey Connolly <casey.connolly@linaro.org>, Casey Connolly <casey@connolly.tech>, Yassine Oudjana <y.oudjana@protonmail.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, Alexander Martinz <amartinz@shiftphones.com>, =?utf-8?Q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <barnabas.czeman@mainlining.org>, Richard Acayan <mailingradian@gmail.com>, Alexey Minnekhanov <alexeymin@postmarketos.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH RFC 2/8] power: supply: Add driver for Qualcomm PMI8998 fuel gauge
Message-ID: <af0e5a39-a4e7-4deb-b915-97a1d9bea19c@joelselvaraj.com>
In-Reply-To: <jddpwqo4f4irukwc725b3c5dmsitjgupcvupvbe7fom7vx2p6r@ilfmls4fzrn7>
References: <20251124-pmi8998_fuel_gauge-v1-0-dd3791f61478@ixit.cz> <20251124-pmi8998_fuel_gauge-v1-2-dd3791f61478@ixit.cz> <jddpwqo4f4irukwc725b3c5dmsitjgupcvupvbe7fom7vx2p6r@ilfmls4fzrn7>
Feedback-ID: 113812696:user:proton
X-Pm-Message-ID: 7af9eea5297f155a20bcc6f692fed3c7ab674861
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi David,

On 11/25/25 5:13 PM, Dmitry Baryshkov wrote:
> On Mon, Nov 24, 2025 at 10:53:35PM +0100, David Heidelberg via B4 Relay w=
rote:
>> From: Joel Selvaraj <foss@joelselvaraj.com>
>>
>> Ths driver supports the fuel gauge hardware available on PMICs known as
>> 3rd generation fuel gauge hardware available on PMI8998.
>>
>> Co-developed-by: Casey Connolly <casey@connolly.tech>
>> Co-developed-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlin=
ing.org>
>> Signed-off-by: Barnab=C3=A1s Cz=C3=A9m=C3=A1n <barnabas.czeman@mainlinin=
g.org>
>> Co-developed-by: Yassine Oudjana <y.oudjana@protonmail.com>
>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>> Signed-off-by: David Heidelberg <david@ixit.cz>
>=20
> This can't be applied, there is no author's (Joel Selvaraj) SoB.

Here is my signed-off-by. You can include them in future revisions.

Signed-off-by: Joel Selvaraj <foss@joelselvaraj.com>

Regards,
Joel


