Return-Path: <linux-pm+bounces-24157-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D94A64F69
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 13:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AEC3AFC64
	for <lists+linux-pm@lfdr.de>; Mon, 17 Mar 2025 12:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A80823C8B6;
	Mon, 17 Mar 2025 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwrdsOwe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931D723C8C8
	for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 12:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742215236; cv=none; b=fA+umVO4xBEBEKj4E8RHp22vGES4rJSrFU+DU+ZVJzZjfNJxbXBUODzuS1FHCc7vGdWYWHpzJTLHpcqHrbbypjdVNfzexgVCwW/9ORaMCa6tkU3vmdrJRe/J0XfP4h96DJYBWmGxplpPkpdyN9fFlwZsm+KtBy0Xd/qG3brKqIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742215236; c=relaxed/simple;
	bh=yypHobI5RG+N9Gi2G3yyYt5vqNyuvH9j+Q9W0NxYZOg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VdRl0BSKJ72iZXTMj6PDvdgDQPk0qCxWZdcxyBo2Vga5NoIRn8+UWOlPoRcNWXGPuzX9MeQi+Ud1JsR55E7mGYnAOnBoH4fzaJinF1eDvuI2is3PEqqcTGRxxJC3fcn8l/YotJLp4mwpmeDMNh+mfXucHpRmHWXHQZGnmfHvYKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwrdsOwe; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac25520a289so762382466b.3
        for <linux-pm@vger.kernel.org>; Mon, 17 Mar 2025 05:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742215233; x=1742820033; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUnk6ZQDhJcRbJjwqZhhAlmnjzY5zVPDLK3pajhTlqQ=;
        b=WwrdsOwe1bLpCvBcvSmRpSrctXVM2mD5qejD1L+uAmrRyPrOlWp1DcoCZrcUPSfyNT
         ElZIkzoAnPQINkrBWe0ZKmL5bQYwvgVrxOm8OFvtX64agVA7f93hy3XJSFBHca7yMzGv
         NxrmSutuNTMSnerk6xpOxeFJa6NvTiv0svnECkHhYzeShUgXBvkS+gYlNi6DDaoSXzqG
         ZtbY1/vRq6qLqUCgJDTsF9bpc9fK/mT9eABIN5Ci4Vm9zYz85yYzrZDn4Ets6WRGFZPc
         0X5zSepI87yUw212ef/E4apc9xE/Fz4pZMDFDyGUxFWF2+VhXTGBfaSyyy6O3sl3SeBR
         S22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742215233; x=1742820033;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:reply-to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUnk6ZQDhJcRbJjwqZhhAlmnjzY5zVPDLK3pajhTlqQ=;
        b=MTKfEr6nENkuSOXpn/nUa5Xe8CkSPUmxZFldG28bPSg6f2GW+jZCFhJuAva5hu/xrp
         gAompQYXBR28hSKj72B7KEJhpJqLvmgvqiD5u7YA+yPE/UPlYIS2IPR3ko/OMTXDpjRZ
         d9vod7GsDS6KxFfEY9ZX2NuhFfqkIKyXqWeavLja8/o3f8mp72s2YUVMRea2GQAxQTxw
         /UuJlRGeRlwIsSZbr263dKl9I/IUKwUvQ2Q5C1QX3o2zatucZzuVUEyVRrSTMlroR3BG
         hmhGzsKZ4L0xxITWuA83gTe7Cx7NAxRa866IVi373eDyMj2v6/7rBzVGpfx+9VwW1wvK
         scFw==
X-Gm-Message-State: AOJu0YyIW8bnES5yQzSipLanFlTYLPS+iS/fIcFR/5XIF7z41m9OLV+0
	REQK5WYwF/+4bqICQibY9218lOA9ECm68D7glnU0pPjDfgwnlc9yoVva9EfCsFQ=
X-Gm-Gg: ASbGncuSBXUOZVASCi1kkLwkH+7KuSPk7K1Esd6CzVsqvj/EIhZsDDmkmc4RWgzEOan
	JFF7wU1MzLCT+/5TkHlFjsuMiNVKQIEmAP2gzPqpG2QGazofstauCXm4VHQWNg8OinQZiN03sCY
	3mAGyKynM+OQCdC946oZ37MZGxfzM5G4/rDOZxPk0BDoZi6IAtQTJyO8KbqRVtkAX5Y72P4ccHP
	RIokNnMnNWiI7n4+RsHBVkNoHHZ25lEt51+VQRsUCHsd62LnhoHTr961QHzjj9p4wn7Qxb7GLsZ
	NLdLmCWH0h2CuKzOgQsn4yHX66ea5iZXfEFQZubJVVTB0yFPga7cRYPMWgoDsm7323AMcEhSB3Q
	Ap9yTevSh
X-Google-Smtp-Source: AGHT+IE4wLuKgBu7QMQFC87bFcDklJAYuP90C0mI/MVZpkcEKd38xxjIIjBW15z8WHbJvAO7mr/HxA==
X-Received: by 2002:a17:907:1009:b0:ac3:3f10:e8e3 with SMTP id a640c23a62f3a-ac33f10ed5cmr944607166b.1.1742215232586;
        Mon, 17 Mar 2025 05:40:32 -0700 (PDT)
Received: from abityuts-desk1.ger.corp.intel.com ([134.191.197.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cf10asm656073366b.120.2025.03.17.05.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 05:40:31 -0700 (PDT)
Message-ID: <07e9d58cb7c6c1ee9696e251953cfd847ad30205.camel@gmail.com>
Subject: Re: [RFC PATCH 1/1] x86: msr: add new
 'msr_pkg_cst_config_control.h' header
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Date: Mon, 17 Mar 2025 14:40:29 +0200
In-Reply-To: <CAJZ5v0gd+Xazbz-ZHqnXS2_geK+f60xZzb4CGbXEWbwiKp81NA@mail.gmail.com>
References: <20250220154306.2166129-1-dedekind1@gmail.com>
	 <20250220154306.2166129-2-dedekind1@gmail.com>
	 <CAJZ5v0gd+Xazbz-ZHqnXS2_geK+f60xZzb4CGbXEWbwiKp81NA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Rafael,

sorry for so long delay.

On Thu, 2025-02-27 at 21:01 +0100, Rafael J. Wysocki wrote:
> static inline unsigned long long
> msr_pkg_cst_config_c1_auto_demote(bool set, unsigned long long
> other_bits)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long long val, newval=
;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rdmsrl(MSR_PKG_CST_CONFIG_CONT=
ROL, val);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (set)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 newval |=3D NHM_C1_AUTO_DEMOTE | other_bits;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 newval &=3D ~(NHM_C1_AUTO_DEMOTE | other_bits);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wrmsrl(MSR_PKG_CST_CONFIG_CONT=
ROL, newval);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return val;
> }

Sure I can do this, sure, thanks.=20

One reason why I am still not sure it is worth it is because the=C2=A0
"lincroft" platform the C1 demotion bit is

#define ATM_LNC_C6_AUTO_DEMOTE		(1UL << 25)

so this function does not seem to be universal enough to cover this code in
intel_idle.c:

static void auto_demotion_disable(void)
{
	unsigned long long msr_bits;

	wrmsrl_pkg_cst_config_control(false, auto_demotion_disable_flags);
	msr_bits =3D rdmsrl_pkg_cst_config_control();
	msr_bits &=3D ~auto_demotion_disable_flags;
	wrmsrl_pkg_cst_config_control(msr_bits);
}

Artem.

