Return-Path: <linux-pm+bounces-1806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C79B823748
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jan 2024 22:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A6E1C24312
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jan 2024 21:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6F91D6AE;
	Wed,  3 Jan 2024 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOSyWYAe"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240E91DA26;
	Wed,  3 Jan 2024 21:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28b93b04446so2087226a91.0;
        Wed, 03 Jan 2024 13:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704318674; x=1704923474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dJaSTSDWLtUQ00fuVpIlouln4xdudcB+SfHwdWcyQg=;
        b=YOSyWYAeFxjal8DW+RkpP9GpV7lEu5dDZnkZAq9OtgA5tJdpRHIinBR93wZX/0kolm
         p6cBB1AlErcZxmPePwDrwKDXlU7mjRNBArIXO+h95LhYSxUXX+5oTYlk4H0WDERYYLnA
         rSQn0vJkuWayE0P5DUZK2j7COw/0zUHGFO4fXdw3wooCEIbG9yDCo4v12eGmys2LfhnP
         xFyZlGwkMK8pqhB+pjA5TyRdfNaiperFMAWE6ibkD9rGpAh/7o5vGM6L3S0ZGy2ojxf9
         yuLc1hUpYVVlLhen6pvtP3z5oSJoXxz2JFyXwyBbcVVDNjErKNhmLm+r6xlJ4I6R/AWo
         dnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704318674; x=1704923474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dJaSTSDWLtUQ00fuVpIlouln4xdudcB+SfHwdWcyQg=;
        b=vGA/yMoNACLkcCmCDgftGvAgFWvHYtfpmHXzSWy8ivjoJL5i6wsMO1P7CQNAOwgHll
         wUgXaHI9WzJE3VbvWWcmNN9uc8bfaxAZkgKJJJYMvHEwKj1AaAovQrSlYP1kMc2/VgSa
         QXNMfZp+4Vs+kjk4j3pdqa8nP00VCOBvKkrFmnBhKj3Wf18EVxJDcM9iz4O9301BzwDe
         cUAERUpGk3Bq1Sj+ylCRVw5Ty9HLmIpcSVGsCYESu/3lJBvrwxu4Zm4W95t9FBZHG1x8
         Yae+eugUcxkpak5wCZKr2uATtgnBQ4ZfKGx20Redht9+lyt3dsWSIAS9/Q+B96CN4H6x
         YWrw==
X-Gm-Message-State: AOJu0YzeC0cvLtRvbusEhjqr3zDSJKah8iDw5JF5eBHXpIyHOkx4CkxD
	ELgWurtKsjUnSdnVImvMqDZBkQ9scEKX6ffPr6k=
X-Google-Smtp-Source: AGHT+IFcRngpFOEX/4Z43AJlFRQL41idrKJZun5zfcv03mqgK8stNt3SwpeybS0/QhxwPGo7bXWIu0p7yiH09IrE684=
X-Received: by 2002:a17:90a:4815:b0:28c:ee93:7575 with SMTP id
 a21-20020a17090a481500b0028cee937575mr1823914pjh.1.1704318674314; Wed, 03 Jan
 2024 13:51:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928222130.580487-1-festevam@gmail.com> <20231002-unheard-copy-f9dceb6498a9@spud>
 <CAOMZO5Di6Saq_r2k8AkGeANRvXwwx26U=Vf5-Eu-_2Qhu5sDCw@mail.gmail.com>
 <20231209-singular-tighten-eef5f7909dcd@spud> <a591318fbba10b764075e9395ddd9f7f@denx.de>
 <20231210-stimulant-halogen-e3aaca2279c5@spud> <20231210153749.GA4141628-robh@kernel.org>
 <20231214-smoked-extending-a76e33621470@spud> <CAL_JsqJ=5zU8NurxJ_b0DKOy6=fo1==yYh=A42R4nvXsCJEKXA@mail.gmail.com>
In-Reply-To: <CAL_JsqJ=5zU8NurxJ_b0DKOy6=fo1==yYh=A42R4nvXsCJEKXA@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 3 Jan 2024 18:51:02 -0300
Message-ID: <CAOMZO5Dzy5zncNMKze7bavFd9MmnMxqD4Gvf7G6e_boHhApc8Q@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: thermal: qoriq-thermal: Adjust
 fsl,tmu-range min/maxItems
To: Rob Herring <robh@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Fabio Estevam <festevam@denx.de>, daniel.lezcano@linaro.org, 
	rafael@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 3, 2024 at 6:39=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:

> Yes. There's not really an immediate fix I see. The issue is in the
> if/then schemas we don't have enough information to know the type of
> fsl,tmu-range. To work correctly, it needs to be transformed to:
>
> fsl,tmu-range:
>   items:
>     minItems: 7
>     maxItems: 7

Is this a typo?

minItems cannot be 7.

- lx2160a has two fsl,tmu-range entries
- imx8mq has four fsl,tmu-range entries.

> This goes back to everything gets encoded into a 2 dim matrix, but the
> schemas try to hide this encoding. My plan here is to eventually drop
> doing that and decode properties to their correct type. That will drop
> a lot of the fixups. I have patches to do that, but then it has other
> corner cases.
>
> So short term, I'd just leave things such that they don't warn or just
> drop the conditional.

Is my v3 proposal good then?
https://patchwork.kernel.org/project/linux-pm/patch/20230928222130.580487-1=
-festevam@gmail.com/

It fixes all fsl,tmu-range warnings

