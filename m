Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBFC333382
	for <lists+linux-pm@lfdr.de>; Wed, 10 Mar 2021 04:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbhCJDDZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Mar 2021 22:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbhCJDDG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Mar 2021 22:03:06 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5FEC06174A;
        Tue,  9 Mar 2021 19:03:05 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id f8so9961106otp.8;
        Tue, 09 Mar 2021 19:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n3GzWJzLNVoqvnXq7RaqdLj51ULbTIFoms5h2/ibyd8=;
        b=doRVoHeDPKyrN7016YfzTEnq9P+bxC7jaEfruXCLYPoaDyfBGxDJcE2aOgSZUB9OTD
         czJog0YA2Wlm4fQNe8dqWfyJt5Y2SQm2LXECeWJSbEiI+XQ0bnLfYXMkCm5RS/M3HwnK
         YVjy6N8ZQ7g/jwt7T7N88IWCIs6tSRJidxsgN2T67nwMVhuHX+nRPEBBQbZRXd/mcrBv
         IfwprcIgMMndk+Wkt9tQaCS631uasZBPCiSoUrB8JRNi2PSyxDSNufOC2sljpEmXaRfu
         QSMNyqT5iUcjzTH0duYr02AnQjra0VZY11qrklDeGDsRcFgPZ5pCvqS1qeXjkG5mjYlp
         kAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n3GzWJzLNVoqvnXq7RaqdLj51ULbTIFoms5h2/ibyd8=;
        b=bgn4v5QfdT9WCTEjx2ekwbMCxhhXmusbEb7MYdUlWzHs8btjSNMhuUHmjRDgkkBNVi
         4Gb1cRCw+XgZiJmo7dfLGTVSWnHt2ZVhQ1wMDl7KMj6KDV2/KXPlTG/u6bre1Ag04EE3
         Ec0MJQC4idjDYZVjPjrCiYmPUq2Holr7xZYaec1vc5WWyUtsF3JR49DjelkqQV8RxAIT
         G9r21jT2cNp/hkzs/yqy1k8+DPl+rUwVlFDANZ+YY1SvxQVw3ZWRcPbsIKqnfoZQEosI
         Oouzq0WMvdHV9UHG+9AU7teGsQ2xnzJncUMzFBVjDRraRJSa0d3EDNd4+SPm/Xo0hoN5
         bPPg==
X-Gm-Message-State: AOAM533tWIDVFxDT+KP+nrguDHyTdPT250xQPYtuOx7A2OdxUt5MDEfl
        ugTmO6nAQx3QFPBCyamT6ihE8c76J4Id8FjZ55o=
X-Google-Smtp-Source: ABdhPJw0mOm6cRWVMQW4f+G7mc7PI9JXOSk/79tDuc+OABVhZU1HkU5qNd9cwG095J1jJlVr5uKCSm3mYj7LTiR5tqA=
X-Received: by 2002:a9d:6c8b:: with SMTP id c11mr1055512otr.52.1615345385434;
 Tue, 09 Mar 2021 19:03:05 -0800 (PST)
MIME-Version: 1.0
References: <1615294733-22761-1-git-send-email-aisheng.dong@nxp.com>
 <1615294733-22761-12-git-send-email-aisheng.dong@nxp.com> <89ce7e90-55d9-872a-59d3-48c3dcadfc9d@gmail.com>
In-Reply-To: <89ce7e90-55d9-872a-59d3-48c3dcadfc9d@gmail.com>
From:   Dong Aisheng <dongas86@gmail.com>
Date:   Wed, 10 Mar 2021 11:03:05 +0800
Message-ID: <CAA+hA=Q-GZMN3xWgR5xn-s5xgWKPGQtpw72rsp_i4y14Zvkr5g@mail.gmail.com>
Subject: Re: [PATCH 11/11] PM / devfreq: imx8m-ddrc: drop polling_ms
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        open list <linux-kernel@vger.kernel.org>,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Abel Vesa <abel.vesa@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Mar 10, 2021 at 12:23 AM Chanwoo Choi <cwchoi00@gmail.com> wrote:
>
> On 21. 3. 9. =EC=98=A4=ED=9B=84 9:58, Dong Aisheng wrote:
> > polling_ms is only used by simple ondemand governor which
> > this driver can't support. Drop it to avoid confusing.
> >
> > Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> > ---
> >   drivers/devfreq/imx8m-ddrc.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/devfreq/imx8m-ddrc.c b/drivers/devfreq/imx8m-ddrc.=
c
> > index 0a6b7a1c829d..ecb9375aa877 100644
> > --- a/drivers/devfreq/imx8m-ddrc.c
> > +++ b/drivers/devfreq/imx8m-ddrc.c
> > @@ -417,7 +417,6 @@ static int imx8m_ddrc_probe(struct platform_device =
*pdev)
> >       if (ret < 0)
> >               goto err;
> >
> > -     priv->profile.polling_ms =3D 1000;
> >       priv->profile.target =3D imx8m_ddrc_target;
> >       priv->profile.exit =3D imx8m_ddrc_exit;
> >       priv->profile.get_cur_freq =3D imx8m_ddrc_get_cur_freq;
> >
>
> You can squash this patch with patch10 because polling_ms
> is related to .get_dev_status.

Sure i can do it.

Regards
Aisheng

>
> --
> Best Regards,
> Samsung Electronics
> Chanwoo Choi
