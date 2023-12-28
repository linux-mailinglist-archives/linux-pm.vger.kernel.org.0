Return-Path: <linux-pm+bounces-1657-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C234081FA8F
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 20:02:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34721C211CD
	for <lists+linux-pm@lfdr.de>; Thu, 28 Dec 2023 19:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19CAF9D7;
	Thu, 28 Dec 2023 19:02:09 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895BE101C1
	for <linux-pm@vger.kernel.org>; Thu, 28 Dec 2023 19:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6dbd87b706aso1160688a34.0
        for <linux-pm@vger.kernel.org>; Thu, 28 Dec 2023 11:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703790126; x=1704394926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bTGSWsWdrnBnSajK8RJvpjNm2gCy8ziMmxsijrHGWbs=;
        b=ghJ1n4s9u10WKsUTTkHdumQjkCuOV0b9ibE953F1Ta+yqXWUTTQTEiukyjATzay/tu
         ahPqYaQRx6Ib7oUDm9y74+L2uAMTM1qvjMdBVPXp6XvXBtN86UuRQUW5q8cQLTK5pYNo
         s3P+pWbLLMBGIoUuMCTuxlwGGxdS3DFUNrsK7Sl5pOIPAZc2eCA31w2TxZMdxClsMXG8
         +oSIsvmHGNHsIAdeb5vYjV/rTXTS+aFV8XCaPTIZiIBgyLkw8JmOY7twb1r7iOtvug26
         exmTTDrVflTCBSMI1pg8YEwX2onuLVfMlUYHSuJFxgY1FVARvPe3nrx5Zv6i+ev8JdiX
         cnDg==
X-Gm-Message-State: AOJu0YyWD9QOx031mDRBeYIsNLB5VMweyeX1RTrtO0b7dfBANTh+luGD
	/Ss4Jwm+3yHD1BkpXSwVXWuY5shZl3dNd8V5F9A=
X-Google-Smtp-Source: AGHT+IEJhy+PCJWSQEKpdJEGeOx9mAY/CBHP48IBxP0hzo4C+KR4msspmWaGk7mFaGR752FQUivcqUKmAnOKfBhrjqU=
X-Received: by 2002:a05:6820:2e01:b0:594:35b4:8a with SMTP id
 ec1-20020a0568202e0100b0059435b4008amr14619088oob.0.1703790126321; Thu, 28
 Dec 2023 11:02:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231228100248.180721-1-stanislaw.gruszka@linux.intel.com>
 <20231228100248.180721-2-stanislaw.gruszka@linux.intel.com>
 <CAJZ5v0gMJFVZToWQPTNstQOpYF9+yDiMYk74dasGp5VWW_-ndA@mail.gmail.com> <b05aef23-edbc-4985-a5d3-7b9ff157bb28@linaro.org>
In-Reply-To: <b05aef23-edbc-4985-a5d3-7b9ff157bb28@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 28 Dec 2023 20:01:55 +0100
Message-ID: <CAJZ5v0jG3YX2j9-COKnCTJnbM-HUVE_vok2xS+CMGpz0r9vGNA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] thermal: netlink: Add thermal_group_has_listeners()
 helper
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 28, 2023 at 1:43=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 28/12/2023 12:57, Rafael J. Wysocki wrote:
> > On Thu, Dec 28, 2023 at 11:49=E2=80=AFAM Stanislaw Gruszka
> > <stanislaw.gruszka@linux.intel.com> wrote:
> >>
> >> Add a helper function to check if there are listeners for
> >> thermal_gnl_family multicast groups.
> >>
> >> For now use it to avoid unnecessary allocations and sending
> >> thermal genl messages when there are no recipients.
> >>
> >> In the future, in conjunction with (not yet implemented) notification
> >> of change in the netlink socket group membership, this helper can be
> >> used to open/close hardware interfaces based on the presence of
> >> user space subscribers.
> >>
> >> Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
> >> ---
> >> v2: Do not return -ESRCH error when there are no listeners
> >
> > Both patches in the series look good to me.
> >
> > Daniel, any objections?
> >
>
> No objections,
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> for both of them

OK

Both applied as 6.8 material, thanks!

