Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B764F7C82B1
	for <lists+linux-pm@lfdr.de>; Fri, 13 Oct 2023 12:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjJMKDY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Oct 2023 06:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjJMKDX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2023 06:03:23 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C02A9
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2023 03:03:21 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-690f2719ab2so377422b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Oct 2023 03:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697191401; x=1697796201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWfFJ+AmBNX1eNwOBM2j0TVV7kILfa5FfGAYJ0JYMSA=;
        b=mR5oLkUA7QclFoiBUgd46hLpgRJOLy7FBqs5hlQngdmv9SXOtyq+CEQMQEGhitUNIX
         pdn7LsdIiZ2o6ExMk4/vep3NGI+sJFHNhnI3Tk9SKeGRhIHKOzqBTQxBnPDqXbJGBlU6
         F+O3cqS81CbvjHyzfk2mKKiXTt+YUBoCiZUitqVz9ekCTuo+zwGFbHcL2V8AnesHPm57
         I5PDBfrtN4c8Q+44HqiH1TE6c1ONOOfzmjuyn9EiZ5lDVknjXj2EynG2IuQXHMlir+KO
         yEUleDmIpKcC1XKGSz2f9/SvHZkPXLQXQXtldGEeE9gDbnMPd8BE22ysumTyhwDREGFN
         s/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697191401; x=1697796201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eWfFJ+AmBNX1eNwOBM2j0TVV7kILfa5FfGAYJ0JYMSA=;
        b=shOOunfPyZJN65dPzswXHIwKxrZj6H+sPYICBLRL7r1UavftW5XUmKQxEzIofvcZD2
         Yz39cAi40ZDs3CAWjYBgeU2OpYHVAp6M2iEWPl+bkEvZnN3H23CoZfqk3vkMRk0Ef8+S
         oBRaQox0r3oo3YBN5CSKYK/ggKtALWtimGTCKYhmgy4dd7uZthwje1g//H+X/uNUY0st
         0eDpshWIGmslwkd0EPfJXbceglDpEnG63iVpcqFF9LHaIxPKs7t0XJfC3iuCUpcXBWiK
         VZiD+HV57sVSM6bufcFW31tQqUwMWFxKsTlcdW8KO2mszDfIm0wrhADGq2dhrT2xTydt
         tyuw==
X-Gm-Message-State: AOJu0YzdzAjzXu5ymL6eho7LqBYmXDDlezyDOWTSwCF9pcOXAT59qyRw
        JBTWa+SNgQOtkIf8ohYC4WAssJBlGUWTu/DSGoM=
X-Google-Smtp-Source: AGHT+IF+6IUafRxDNMCmEM6IwXRtfWeZ5ex4IZw7IINBJYJ5SalZET+C0euJJfez2plsgvKIAZAJRTMrqeLXjn0RmJM=
X-Received: by 2002:a05:6a20:4407:b0:133:6e3d:68cd with SMTP id
 ce7-20020a056a20440700b001336e3d68cdmr35914891pzb.3.1697191400830; Fri, 13
 Oct 2023 03:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231012132214.257207-1-emkan@prevas.dk> <78a905b6-020b-4d99-94d7-f09ffe4e156f@prevas.dk>
In-Reply-To: <78a905b6-020b-4d99-94d7-f09ffe4e156f@prevas.dk>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 13 Oct 2023 07:03:09 -0300
Message-ID: <CAOMZO5Aci5-LsLPJw7awRLMdeE9wc2OL92vx-f88DQuCnZpStA@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: imx: gpc: set fwnode from parent device
To:     Emil Kronborg Andersen <emil.andersen@prevas.dk>
Cc:     Emil Kronborg Andersen <emkan@prevas.dk>, ulf.hansson@linaro.org,
        saravanak@google.com, linux-pm@vger.kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org
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

Hi Emil,

On Fri, Oct 13, 2023 at 6:57=E2=80=AFAM Emil Kronborg Andersen
<emil.andersen@prevas.dk> wrote:
>
> On 10/12/23 15:22, Emil Kronborg Andersen wrote:
> > Before commit 3fb16866b51d ("driver core: fw_devlink: Make cycle
> > detection more robust"), consumer devices without their fwnode set
> > printed errors like the one below:
>
> The commit message is wrong. Instead of "Before commit...", it should
> read "After commit...". Do you want me to send a new patch or can you
> fix it?

Please send a new version with the commit message fixed and also with
the Fixes tag.

Thanks
