Return-Path: <linux-pm+bounces-1094-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB5C811314
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 14:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30A71C20E96
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 13:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C4F2D04F;
	Wed, 13 Dec 2023 13:37:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2694B95;
	Wed, 13 Dec 2023 05:37:57 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6d9db2f1ddfso1032486a34.0;
        Wed, 13 Dec 2023 05:37:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702474676; x=1703079476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ZUkkC62WrEEa3c6+GRaTxNGlZbmcSMO/iY5g7nd1ts=;
        b=XxeevKb7UA3TH/JjArIFdSLcI4rXKjlcG3cYQP6QszRqbhFISURYz4XypfoG9xTQRs
         7v6oHgoH/JCrzYYB4sgMhttehXZDIeKkqpRHC2itb2IHQ4dRgpfowcgmaqjiCU1fHfiP
         il33NlHt4+YyaVzfKjtL7GoNnOaI25qY1m7jX8eNZLxRr7uEovpb0xe39CuiPfQCpULk
         tAU+T/195wPNDfa+6IxSbc36QqpsE9kN+aFFzcNivO0oJ5t5+LOVKbl1F6u1iBgeqwTD
         6MsM/iWTZ/DgDEtK1AZUitb+K/pJQUvZhGxeudpI/LKCR1T98o4DkddcUwxqccIp68pb
         k3YA==
X-Gm-Message-State: AOJu0YzOoDt9bBX7aX9XO6toTbYf4QlyeXR3VngEh9H4tJwun6eCKYr2
	dSePhvSlqFnPDQ5VuLBDJlusafODM1+SXgnVgF4=
X-Google-Smtp-Source: AGHT+IFmc+A9rorq/rOdGz8gjI08UuZ4ZgrInVsHLw0n8i3P7dAy8xko9rmmdYPzruTZNBiDN83j7nxY/28jo2J/kqM=
X-Received: by 2002:a05:6871:600d:b0:1ff:6527:3519 with SMTP id
 qx13-20020a056871600d00b001ff65273519mr14455355oab.0.1702474676254; Wed, 13
 Dec 2023 05:37:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213121322.2486967-1-daniel.lezcano@linaro.org>
 <CAJZ5v0gjeiCb9wBjdG+yWp5E_g2SPUMNNf-Stm_xkGau0Cbr2g@mail.gmail.com> <c7e4a344-ef15-4316-ac41-6ec9c062eabe@linaro.org>
In-Reply-To: <c7e4a344-ef15-4316-ac41-6ec9c062eabe@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 13 Dec 2023 14:37:45 +0100
Message-ID: <CAJZ5v0jOAEJx1xcRZ5ybz2dKXMG4CbEmShE+zQJy=0gdqqzbPA@mail.gmail.com>
Subject: Re: [PATCH] thermal/core: Check get_temp ops is present when
 registering a tz
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, "open list:THERMAL" <linux-pm@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 13, 2023 at 2:31=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 13/12/2023 13:46, Rafael J. Wysocki wrote:
> > On Wed, Dec 13, 2023 at 1:13=E2=80=AFPM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> Initially the check against the get_temp ops in the
> >> thermal_zone_device_update() was put in there in order to catch
> >> drivers not providing this method.
> >>
> >> Instead of checking again and again the function if the ops exists in
> >> the update function, let's do the check at registration time, so it is
> >> checked one time and for all.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >
> > Looks good.  Do you want me to pick it up?
>
> Yes please

Applied, thanks!

