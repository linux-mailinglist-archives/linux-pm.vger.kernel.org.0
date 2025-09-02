Return-Path: <linux-pm+bounces-33659-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6548B40B52
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 18:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C4C1B26C3D
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 16:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2211333EAF3;
	Tue,  2 Sep 2025 16:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G4uUGFLw"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9AA30F94D;
	Tue,  2 Sep 2025 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832273; cv=none; b=NjnXJcmaaM6HkmfBFp0hnxiILuXTh0x2RwOAZO956sVtnD5exJeiShyN87QaDu85JQ5fTNwK+mj0KqKUIB3gYxT2vVjknkcY/QufkDI3PPvjm/W++MYiSHCAjimH11+Gvso3CG/K5Z1G+68L3yGu3I6S07JTkDsD+cxGlzUouSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832273; c=relaxed/simple;
	bh=xjZdrMmxgQtX66TPP8v+Vqq+oEDA+LsGXidCV2cNP9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZ3CXrXneq+rxGxiO6yUreFkpiMFLOy6KuOPUaPm7r55ABIg0yBy5YzUYuODS2apgbczs+cZgWVeocLyK7U1HCuC6TmX+GWuQx6C3zl9D79v6fUuJUqz7cIWtbTKGECydcn57euDEH6RvZACDO6/WtzPatXVq6I2p7IjgcHGRKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G4uUGFLw; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55f69cf4b77so3968280e87.2;
        Tue, 02 Sep 2025 09:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756832269; x=1757437069; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USMABpzeN1jg9NNbpP8+DcIerB0Re2d1/c7KuEPDElE=;
        b=G4uUGFLwy2ZH7Dv7lCRGy00i/Sm/IocCayBz9ttTMOixOFOzupMcjKCOjMfClYSR21
         ngzhXES9dxWKJZIlCzjk5yZWPld647iVI70ij+lkWpxyxirVBtl8cItTPz2Ng+KOKg+B
         YxrafEbkYNpcQUGGh77aWXoGt+jkZlv+CxX/EhRDpNOseCi/IGRFyfQ/nCTdX2hMWtwJ
         7EOhG/nt6Ry+r0Da6VtL/RE//E7MWGsf8dR7ru5za5/n4t3AQ/bxEkQvic5i9LWVoTzj
         58HxwTrAtxhAkjJbJdjSCcdiK1baFLPdUsq1SPl0iHQeNMvtgMPO6rcQSJaZVlrgkOYE
         N8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756832269; x=1757437069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USMABpzeN1jg9NNbpP8+DcIerB0Re2d1/c7KuEPDElE=;
        b=tsLpEpyN1A2Wh3IWzjPLUH6FlKs2+MyW75IkDIuYmlzefK7mftv1IN5GQm4Wf4OouO
         lTv9RveazBvprDhokYbN0Hckkr7JFaNIW6BvbHCDyemSZwnFtJQPQ0Eg+c4uC3metn9T
         UfmCJStjPC+BiqylK/nhVijAfmzORGw3K5KZhi+duKZGC3RkEvZSE4b+FM6ni0bvNy74
         Kh93gCllqtSMGskXvAO8OEIvAG7UJgxCqeOUzS1klFHR/1HW6zNcdpz0un+KSgA6Gnvp
         F1McYJ4NSaFGr+8rvS6cuciOAF6VzXoJ5xW18tqWscQ0wUcBy7/oomNOXpgnR97E3IES
         7Z1w==
X-Forwarded-Encrypted: i=1; AJvYcCU9mBPXcskPihfJ2GlJWCln2G8T8DTNBfM2rmWGPNLEbM7ytaMYwyvavDcB/CEnYIzxoSQMIIeEpjD+Cd4M@vger.kernel.org, AJvYcCWi2OluK/g+wG4dHzcxYbVM0pMMU7flFH28HfxwYaIDsZgWST5tM4UhUixGzU89mluOBQDZtoLNEIA=@vger.kernel.org, AJvYcCWyAOj0JighmIp32Mcp0M5dhhSzOQ1qkGr2IoMXcpBVWNNVfXkGSdFisCD1fEEb9dROspi4eDOBymkL@vger.kernel.org, AJvYcCXm7JrEUx4goNAF/A/bPblVPfrIQfCxSToFc0LjThTRjIVayGMH+kf4kHsrK5AV+64T9gPZhuI9ZPd16eQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YylWTD3kAbei5kYL1NMcouSgA+hhgr84DK/K49Ok/XhGTFGzvZN
	rIhbTbFDiw76oNcKGEeSNzcvMbDwb/9UO5aTCgyTsD+CHOu+iqMFIvZIF1bMyPz2qfe0+66+wTc
	pDScAMNVZqbkYgQIl5MDLyiyI9N3/1a4kOyfgBFexKg==
X-Gm-Gg: ASbGnct3pZYYhQJN5kSEA9XBTd28Dz+sw1aM5xOjMNYgKEsFCZO1jb1Ky6boJbDlqaR
	i/WvixH5OyPmDlHyEdcxsYmzQk3m3b5k6SR/57G9ahh7YZH9OVfjwbVaPxNuEWfz33LSAGcPknn
	JpGJlSlWOSNJrvWf/q8ujMhJjq+tC5XdMgpH1StW1wl3t0kWTasrpILHCpW9LYaWkgZ0B5k4l+m
	WWW7q0Tmpr35Ec4WQ==
X-Google-Smtp-Source: AGHT+IHhfyehhL9dzCmmW7RKEpzEoQp3xfJMMII4o8LTS1/yYrgYDUDOmVLVqNX1VUdzQSoTOGBSF65LedRhnwtIiBI=
X-Received: by 2002:a05:6512:3b9e:b0:55c:e95e:cd63 with SMTP id
 2adb3069b0e04-55f708ecf1dmr3560056e87.30.1756832268893; Tue, 02 Sep 2025
 09:57:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250831-tegra186-icc-v1-0-607ddc53b507@gmail.com>
 <20250831-tegra186-icc-v1-2-607ddc53b507@gmail.com> <20250902-curious-cooperative-agouti-1efdcd@kuoka>
In-Reply-To: <20250902-curious-cooperative-agouti-1efdcd@kuoka>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 2 Sep 2025 11:57:37 -0500
X-Gm-Features: Ac12FXzEK5elSQZytKBQDMCCZLo03Xy4jbKPZ68ZK5aetWahruENEzoM8bpe-ok
Message-ID: <CALHNRZ8VBXnf0UULDP=fqGSEYvWXoGhoY10P8FyHbYGwi9uY4w@mail.gmail.com>
Subject: Re: [PATCH 2/8] dt-bindings: tegra: Add ICC IDs for dummy memory
 clients for Tegra194
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 3:25=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Sun, Aug 31, 2025 at 10:33:50PM -0500, Aaron Kling wrote:
> > Add ICC IDs for dummy software clients representing CCPLEX clusters.
> >
> > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > ---
> >  include/dt-bindings/memory/tegra194-mc.h | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
>
> Please use subject prefixes matching the subsystem. You can get them for
> example with 'git log --oneline -- DIRECTORY_OR_FILE' on the directory
> your patch is touching. For bindings, the preferred subjects are
> explained here:
> https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-pat=
ches.html#i-for-patch-submitters
>
> dt-bindings: memory: tegra194-mc: (or nvidia,tegra194-mc)

For reference, I did base the commit subject on existing commits,
namely b0dae3d which these patches are based on. Apparently that was a
bad reference. I will update as requested for v2.

Aaron

