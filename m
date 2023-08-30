Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92E778DA6E
	for <lists+linux-pm@lfdr.de>; Wed, 30 Aug 2023 20:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjH3SgU (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 30 Aug 2023 14:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343794AbjH3Q5Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 30 Aug 2023 12:57:16 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E56519A;
        Wed, 30 Aug 2023 09:57:12 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-26fa19322b5so776011a91.0;
        Wed, 30 Aug 2023 09:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693414632; x=1694019432; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BURaWLOYfvtaJ+AWusrw3s3uuOPvA+PnB6nu7+1ia1k=;
        b=B/qowTq/XxSAPVC6+kEGwH/qmpNMpwQVN2Y1qQNXzJVG8gJmuzEG09AJXRbfMtyeus
         +flWbJ/n5zzE9UQi39PTv9d67LdIi74FfQIi1pzYuZKVsjHTGDMCNTDzkjNjlK+mTDV1
         dH+RvodW/6zxQfKME8mRNd8g+5YOBfDppG93JcS/DZNftoUmidde1IDklCVT/zDyEV/e
         rfIczGRIfu2r4wjko60bL3HsPLYK2TSVM1OmZEZ5ohaQmxZzK9xIrgXc93pmXw/bl4zT
         80MbG0MdXvGl7KIJBt6Z7Uac+xomf8gRUC4t9a8XVUFrD8XeFnjU8GhfQIPu4T+39pGw
         LoTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693414632; x=1694019432;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BURaWLOYfvtaJ+AWusrw3s3uuOPvA+PnB6nu7+1ia1k=;
        b=ajfRAhwtXr1q5vUNgUSiqoKstTwbBEzKL9xy12r6AFI6PbxaDd+qFb30Yre6XPZ6Xi
         n60ihgZR6MY4hP57I9O/ndtDZ6uJId7uLNjTa481PMmP9LoZ+1ZHvhHkBBMXIRke1oFp
         bC9H80Hnlly+Lm1nuAvSZ2OjhTm9P6XADnmzfIIMTOPEEOuZIyUlKAf3dPpsgo5S/rwE
         pC8xD7NHE2mT/ui6j6fmJwkJ4goYSaGzPHYHRCsludf+Nr6KXSO6X4mfqqxjs5hipQ/G
         dZqLzFAkxBYfwqsvj6McEHq5WCTSOZ8voLMcxrv1hXFkchAbL+UMKOdtFo4a02yTOea6
         WGOw==
X-Gm-Message-State: AOJu0YxXP0EURGx5G7fdvGPPNPmUfmzmX0vhIrpZXM2cFfQd90N6vbTa
        mvAMn+pdWlOde/hOgRMsU6cvMokxi4uwSFJYO5s=
X-Google-Smtp-Source: AGHT+IFxyuef2rfThehbuuN3O+u23zY6GHnSxgZKBmpx6EW8qnlaSXj3gV0xKe/VLNKM38MtQufoK8p3vKUOeRrAskk=
X-Received: by 2002:a17:90a:9a4:b0:268:ca63:e412 with SMTP id
 33-20020a17090a09a400b00268ca63e412mr2538338pjo.4.1693414631979; Wed, 30 Aug
 2023 09:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230830151908.2149847-1-festevam@gmail.com> <20230830151908.2149847-3-festevam@gmail.com>
In-Reply-To: <20230830151908.2149847-3-festevam@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 30 Aug 2023 13:56:59 -0300
Message-ID: <CAOMZO5Bh1oE14Ne9gPd7=M398S-HXXjZPza6F4-885pe5Y0ESA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] thermal: thermal_core: Allow rebooting after
 critical temp
To:     rafael@kernel.org
Cc:     daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Aug 30, 2023 at 12:19=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:

> +static const char * const critical_actions[] =3D {
> +       [THERMAL_CRITICAL_ACTION_SHUTDOWN]      =3D "shutdown",
> +       [THERMAL_CRITICAL_ACTION_REBOOT]        =3D "reboot",
> +};

Sorry, this should be removed.

I will wait for some more feedback before sending a v7.
