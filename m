Return-Path: <linux-pm+bounces-33670-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA547B41188
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 02:56:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D789C1895E8C
	for <lists+linux-pm@lfdr.de>; Wed,  3 Sep 2025 00:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83193199FBA;
	Wed,  3 Sep 2025 00:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mu57fO9m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA602195B1A;
	Wed,  3 Sep 2025 00:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756860951; cv=none; b=J2INQP4X+v29etkpIyBXvBjs0Y7FUSC9T0OPf7dd4mzj3onLujRcYhuH+U1TLfef6WkLK+e+uXB/XjKiex9OJTchEE9fara753B5+7+EBLJevXpGJH9vluXN3Z5JANCNJ0Pbs0WUIwB/mi+vZv7QDRcpAa+5Tc34UmDFSaI4bag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756860951; c=relaxed/simple;
	bh=swZueAhBXSwklO7Tf/fSg9bLL3E16TGenKFw98dM9Wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GIjJO/cRN+lWId6rOoIVrKT/LsGrcV99/ARoZ7akIvvUr9AHDWwEqvCiTZLf4yrItLNUTUtppa0C25pVS2msfTdwQ/rsgXfneCij8cAOSCFNJk1ZNVinfBZtOgv3tdiJBeqSt5g760Qpz9shlX3HR3n0/PWFzeLJFWaJFosmqbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mu57fO9m; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f6186cc17so4936739e87.2;
        Tue, 02 Sep 2025 17:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756860948; x=1757465748; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=biFf42usLj+Vl0gHJRJPvudXd19GDtQlKIRujcLuh50=;
        b=Mu57fO9mnGb6wQSV+akQdt6rmo+F4HgUyAwJOWsLusZGtIAbX/8T7luezRG4M1GTwe
         IwaF/WtoCNw1YbukPpB+BwOHqYNz8hsXc2F1a048CswPc6SiMlp65cqonabI0Cl43t33
         inC21+ZGelYIPKYx4fo9ylAUwJVP7HkH99lmNcszSSIK6qPUU4vULvfmC0pw7FG9ftWN
         SYoyFVmCLGYxh+QekGzD37IaVe+ifWornLB0z+RvxRSIKvYPGouS/hzkNnKiiIIlq6XG
         JaOMVcl6oLBfFSeuqxh1s8GZrxuTblvYAt8ie/OhAHP/Av4encivn0LnlODPVgOjfyjf
         kt3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756860948; x=1757465748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=biFf42usLj+Vl0gHJRJPvudXd19GDtQlKIRujcLuh50=;
        b=b79mY24GRpZOPKK+v09e9kQj/YQVTXDoqqgO2P9DehjMPes+pCIacJVKmyqmgME+Pv
         24BJrDSimsAR+7mgGExOsN9CRnkkhApweNhdCVCC6xvuEO8ETOugODWR52bXDXaqLDf4
         x5xgW0C5OB2uo4vcHt/ewEuMGc0Bgj+6EnXYhWeKhu0bOzxKMrqg1DCW4OJlr6mek9bM
         iJs9o9sdIZATWKUlPDbM+J7WXnlToUPIUFkC/XK7o3M4wHTcXYV7eR1/lmeahbufEavl
         JmIEXvcUQlJdCYP2BbW6AzTG4LCUePP792FsBI+GxDMs1wqBovv9111iewHt2AjH4Qp+
         UqmA==
X-Forwarded-Encrypted: i=1; AJvYcCUqgbcEnKmF6j+7u5wn2SCNt8nwA6ZjzgklOR17EDp+cshmDXVUB1lsAJyXQp9rMBYxWvQhwIRLw1U=@vger.kernel.org, AJvYcCVf4KttbraW5K+Srr1jsHxJeeR0QlncYToH7smUPj5Qc2nug64T/rVPGCj8Hk1JG5O5oajv117av+NbYdw=@vger.kernel.org, AJvYcCVr5+TxGrXHUcXFq67BqOpC7nCN2h5MiZ1vWBqoSoEQ+pGn4iMOCxutKzpnvH7bw9A7X7nYnzJZ+OGF@vger.kernel.org, AJvYcCWT0vnE3PQz9gNBZtsujdU5rNYteRbrQvQsfyrbvZx8QXNImLtOUlyPzovXKo08QQztVLeMq0qN9qCo94dM@vger.kernel.org
X-Gm-Message-State: AOJu0YxiAx+OkbNS1TooxE9zYqbZOX8tNXB08y7uXRaKFSpVhdfvKLYT
	1FdrXf2SccMK7Vd9yoYE7NFh4S8F6rKW0frmpDW71PtqLuCQmG8Xr1y8PMCCDayKZA7xywJEgIO
	08YieNF1Xlay6aEgtCxUhvbYru5RUb1M=
X-Gm-Gg: ASbGncu8DWzysgY0+C/VPa37OzL+tH8bbxIjgWqeQV8ZaH5vHbZsUhS4Pu1ad08L+iD
	n0kNHbnuKod3gmPhRLdnScBSgtCYYuVXphVwfGrPJF9IC5Ve9ITYnv+M7qDc42druMeCZGMBQ9f
	zW4/E6Mp+v3VUPchnJLaDTOaQkaivR4J/PV9Hv66g1fJ/VYPLm2q42X8KfYZLy6QLnHNcOKu89k
	C8sjtOp
X-Google-Smtp-Source: AGHT+IGPZiMfaP1paVpXDCG7OlJWEUH8L/hCasKQtaW7zajb61su/qh6PDSxtn5RJPKHGKRCZNKuZzFMs+Ee/c4fsFU=
X-Received: by 2002:a05:6512:4045:10b0:55f:71ad:5913 with SMTP id
 2adb3069b0e04-55f71ad6048mr3433585e87.50.1756860947536; Tue, 02 Sep 2025
 17:55:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-t210-actmon-v1-0-aeb19ec1f244@gmail.com> <25477710.6Emhk5qWAg@senjougahara>
In-Reply-To: <25477710.6Emhk5qWAg@senjougahara>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 2 Sep 2025 19:55:36 -0500
X-Gm-Features: Ac12FXyiMmcEPBnXVhKhTD563A-aPjl9MtxAaVDXptfjkCQhW65cAeinrQCkxqE
Message-ID: <CALHNRZ-660RVcYLo9Pxxj9gz1s0x4nLYOSFwbtiEwSU1qbvA5Q@mail.gmail.com>
Subject: Re: [PATCH RFC 0/7] Support Tegra210 actmon for dynamic EMC scaling
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, 
	Dmitry Osipenko <digetx@gmail.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 6:51=E2=80=AFPM Mikko Perttunen <mperttunen@nvidia.c=
om> wrote:
>
> On Friday, August 29, 2025 1:01=E2=80=AFPM Aaron Kling via B4 Relay wrote=
:
> > This series adds interconnect support to tegra210 MC and EMC, then
> > enables actmon. This enables dynamic emc scaling.
> >
> > This series is marked RFC for two reasons:
> >
> > 1) Calculating rate from bandwidth usage results in double the expected
> >    rate. I thought this might be due to the ram being 64-bit, but the
> >    related CFG5 register reports 32-bit on both p2371-2180 and
> >    p3450-0000. I'm using the calculation used for Tegra124 and haven't
> >    seen seen anything obviously different between the ram handling on
> >    these archs to cause a different result. I have considered that the
> >    number of channels might affect the reporting, and factoring in that
> >    variable does result in the correct rate, but I don't want to assume
> >    that's correct without confirmation.
>
> My thinking is also that this is due to the channels. L4T says
>
> /*
>  * Tegra11 has dual 32-bit memory channels, while
>  * Tegra12 has single 64-bit memory channel. Tegra21
>  * has either dual 32 bit channels (LP4) or a single
>  * 64 bit channel (LP3).
>  *
>  * MC effectively operates as 64-bit bus.
>  */
>
> next to calculating bw_to_freq, and proceeds to use the same divisor for =
T114 to T210. Regarding the CFG5_DRAM_WIDTH field, I'm guessing it gives th=
e width for one channel, but I'm not sure how it would function for other m=
emory types -- I'm not sure if any Tegra210 devices using memory other than=
 LPDDR4 were ever released.

Mmm. "MC effectively operates as 64-bit bus." So I could just hardcode
64-bit dram width and skip reading the CFG5_DRAM_WIDTH field
altogether. And regardless of the layout, if I'm reading that
correctly, the calculation would remain correct. That should get the
numbers I'm expecting on the devkits, but I will verify again before
uploading a new revision.

Aaron

