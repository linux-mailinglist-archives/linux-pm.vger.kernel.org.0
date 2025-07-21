Return-Path: <linux-pm+bounces-31162-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A57FB0BDEE
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 09:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2FC23A5FC1
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 07:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C32284B2F;
	Mon, 21 Jul 2025 07:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="ZHmo0Ofm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4F5284694
	for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753083763; cv=none; b=k/PBVBAdFUKc6LkYpUmi7bIG1yEFeG0pubOUD5f2EJh5OAB9w2SHz4cHrWhn+M8h/skaohCDDFQOwe3eN4cuBsUOS5o/stWvGay/MMs32uVngOnmJ75j43R08D72f3d/w80i/Vj2lKRAKE+Z7kcNAaOkQu9KDfynFSWsiaWhWbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753083763; c=relaxed/simple;
	bh=chzQDhpRR0KkFFSvGWLDbsXZDi/1ZGpp4j7nqK/5mxo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=qphgK/CXXhKoq95ojj0ezOLjn/lEAg+WNWL7co3eJSKoQ25eZd+AgdfA3n4T3jRsgYU2FeDMbdsjyq9U1TBfG8g4Z7y8V1RR4D/7M3mYCiWnOSEws5Ft6HsxxAAVUdsqXQL+JRPXqckPXdAArxOS+M4SenWml4Ned2raGA4IkXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=ZHmo0Ofm; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso702709066b.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Jul 2025 00:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1753083759; x=1753688559; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Jn2uM1C1hodxQz3Up00DI8ehhdUTfz2Vy9NLN+SJQA=;
        b=ZHmo0Ofmh0GkYtbtnBrkBXAph6ck5S93mdvYHgMT1Cne2rvnNOQkE27CEbOH1xWS/7
         NhgvCVGwAxxwAxh22dRuKuoulqNM/d/FsUKcb1VemcCWyMYH6QgERk6Q5tOpz62rJ3QC
         zIhQHa5gKeToe3Un+4ndbomLZDjnQMxtXkTO5MWnxxlbEnNeq+td2/Ll52U7KBTMz+Sc
         +aVIqO0NTLIbMfJVE6AyOWI25bcEen6y3VcNIEKh58NRUzqIG5si1ez5wHVgcp2YseYr
         vXxugd/AKgiPEnver6TieHzQH8MHdowWSrW/lf842esl8Y/aPjTuhRbtFzirf+5gDuRd
         nZYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753083759; x=1753688559;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/Jn2uM1C1hodxQz3Up00DI8ehhdUTfz2Vy9NLN+SJQA=;
        b=PVZgbGVlPlcO3Fm3Sog5tDQD0ttklDjcsNmx1dFO47dWkZek8gYIr7MCthrHOV6Dy5
         h0tyz3F1iMkTl1Mdy4654ApRoTcWzeYq6utnJ6kVPm5cyQBi5ovv/QcMBUUN7vfr/1nH
         7LkDnbPc1mfZDTh6f1xquANlrNC2BKFWGZerrgGFv1Av1hgX0pWPbj1AfkoIND7a6Nhv
         7oUkLjlSoen/ll8uP5xJIZyU/t2zDFpzO4jonqnpSg2f8K5aYHUTpmDXZKg7fk3vsxg9
         +foQ7za96GY7OUtmcn8SnQjWur1hiWWsjCVkhtBtxemjcQ1XRarT5s6dXOboy55oRgO/
         oGIw==
X-Forwarded-Encrypted: i=1; AJvYcCWRFvmpi+fmFgNgXOP6G7XnVfd+zk0OJlvEGR0lMFsp2uL3DNXgh/+BCRu2TuWrPPhQC0qeKI5xiA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwoXspHxmDfDlS/WMUbsElreciocc8RJToCrBg7X+MOBkynH653
	CZBp+vZSwUi6kbPkL850V2JMVxzJ7LJtU+K5XbP3yVJa014CLfo7cEslojIFz237U0M=
X-Gm-Gg: ASbGncuhtudCbL70xQ0KsB8tFaCZWfft09oYcERXFYFFtEyZqgCsUYOGaPcCor8szS+
	h4iwY/PObtsZmUgwjb/uRqEFPF8wKU2jgIGX3hdA4GvqvRsPLvFL+BfBNdTu0DKHBcU9/JD3EyR
	fGetWfhRe5jZ/nQAw9NLvmR6EYcqKQDdMAjy1SbJY7arR4Eo0iG66tabJKf856ihTawwblFWzT5
	zePlAioOka28oYAV/tyC1U4VFgHtrryfjo1LOZM0qUR3t6G0mCXg4GnXJFREDPJH1sxNZpwsBAa
	r4nB9mbNsxjVxiOBMMk8XVNPZlgPzUdLeKU1GxWgYKYXiYNC5Y46obim3Nm/alXdFT75LNTuYgY
	GI54djp9oG/5Mq1DQCiTI1Cih/g5Xj5zv3cjTqfj88h0+6VB+R+xUaE/SLiZk2zI5PYfuCh5R3r
	h2UrEB6cNiKetqHDp8HP+88Txbqfj1sQo=
X-Google-Smtp-Source: AGHT+IHojokpIKOVzO2mTGfd8U+xB3sxarTMHuXH9C3us/pGvkjTIHvaL7YhUPwGxvFGX/BiGyYmDg==
X-Received: by 2002:a17:907:a901:b0:ae0:a465:1c20 with SMTP id a640c23a62f3a-aec4de61a29mr1564976266b.14.1753083759251;
        Mon, 21 Jul 2025 00:42:39 -0700 (PDT)
Received: from localhost (2001-1c00-3b8a-ea00-c4de-d39d-05f4-c77a.cable.dynamic.v6.ziggo.nl. [2001:1c00:3b8a:ea00:c4de:d39d:5f4:c77a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6daf4579sm615655866b.77.2025.07.21.00.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 00:42:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Jul 2025 09:42:38 +0200
Message-Id: <DBHKBSK14XHM.E3ZUQMEJKEOJ@fairphone.com>
Subject: Re: [PATCH v3 2/2] interconnect: qcom: Add Milos interconnect
 provider driver
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Georgi Djakov" <djakov@kernel.org>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>
Cc: <~postmarketos/upstreaming@lists.sr.ht>, <phone-devel@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250709-sm7635-icc-v3-0-c446203c3b3a@fairphone.com>
 <20250709-sm7635-icc-v3-2-c446203c3b3a@fairphone.com>
 <d8955532-9a3b-451f-b5c7-549cee7d749e@kernel.org>
In-Reply-To: <d8955532-9a3b-451f-b5c7-549cee7d749e@kernel.org>

Hi Georgi,

On Mon Jul 21, 2025 at 9:36 AM CEST, Georgi Djakov wrote:
> Hi Luca,
>
> On 7/9/25 4:14 PM, Luca Weiss wrote:
>> Add driver for the Qualcomm interconnect buses found in Milos based
>> platforms. The topology consists of several NoCs that are controlled by
>> a remote processor that collects the aggregated bandwidth for each
>> master-slave pairs.
>>=20
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>> ---
>>   drivers/interconnect/qcom/Kconfig  |    9 +
>>   drivers/interconnect/qcom/Makefile |    2 +
>>   drivers/interconnect/qcom/milos.c  | 1837 ++++++++++++++++++++++++++++=
++++++++
>>   3 files changed, 1848 insertions(+)
>>=20
> [..]
>> +
>> +static struct qcom_icc_qosbox qhm_qup1_qos =3D {
>> +	.num_ports =3D 1,
>> +	.port_offsets =3D { 0xc000 },
>> +	.prio =3D 2,
>> +	.urg_fwd =3D 0,
>> +	.prio_fwd_disable =3D 1,
>> +};
>
> Thanks for adding QoS!
>
>> +
>> +static struct qcom_icc_node qhm_qup1 =3D {
>> +	.name =3D "qhm_qup1",
>> +	.channels =3D 1,
>> +	.buswidth =3D 4,
>> +	.qosbox =3D &qhm_qup1_qos,
>> +	.link_nodes =3D { &qns_a1noc_snoc, NULL },
>> +};
>
> It's very nice that you switched to the dynamic IDs, but please use the
> current style of links (like in v1), as the the NULL terminated lists
> are not merged yet. All the rest looks good!

Is what's in todays linux-next a good base? Or what branch should I base
this on? But correct, I currently have v2 of dynamic ID patches in the
base for this.

Also If I send the next revision by e.g. Wednesday can it still go into
6.17? Just wondering how quick I need to work on this.

Regards
Luca

>
> Thanks,
> Georgi


