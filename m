Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929176B7134
	for <lists+linux-pm@lfdr.de>; Mon, 13 Mar 2023 09:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCMIdc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Mar 2023 04:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjCMIda (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2023 04:33:30 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB41219F1C
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2023 01:33:28 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id p203so3680327ybb.13
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2023 01:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678696408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ya0xeR3EOwIf2SQwBchOfop6EHpJp/mskrRR9QbQKU=;
        b=ulacoDZkaeqpJxaGwNgh41bzF3Mu0/3b4OqyAvKgxKFWQYsb8nRc5fcQ0riYXDY8yt
         smy4lCoCdN6Rtwj791c+Ib8RAkUysTZAguLKWGAOPk9qq67kF1IgeCFVQTEQfcZlE7t+
         wbyllsVuvw0dIx5r/r9Uy8290CTjwUdZNicO6KKs6wQOd5AhoR+NQ633EQBiaqA4qUqq
         leXmeMVZACMGHsRj9I/ZnRnNXLmhsMeD/6UJ/Jr+i6FHYkll0S9SYNXaYmlsBUfdeZHg
         bhhom6zFIomkoS9E/fCJUM8zWU+lVxzQCAYwqludjFQ+N02O5pXSjVd2NrS2+tVFaCPs
         V0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678696408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ya0xeR3EOwIf2SQwBchOfop6EHpJp/mskrRR9QbQKU=;
        b=2yfq/5JyW0ImEFe/aM+GNAXJk7ix9TsgiXdENQkY5feZqxtrBo6B8wCQ64Noj7CIPq
         +WOk/p3LN5Cbi2jO7F0yt0npbbV54u60o1CrDLLwZmSAnq+6Bal3KCaCXSRxpCyPqgIm
         io/UTBh7Lns5NSSPB+rKTUxZ/abIFC2jeFKwYO7otL5jfHU561L9nG2A0ScDOJxgOaMD
         YkIl6nHbVSUlX+DG9BUdaIVPMNKuFM3Rm617zO6l79haEdn/OAL0JoVgAWgSXLLbNKtJ
         QeckyBIq9Lf94JkOn+y8V9kYXSh2oF6LGldWqMGZSbeqJWyBqoXz4iCbKSrY8y1o9uYR
         b5oQ==
X-Gm-Message-State: AO0yUKVrs8nckhrvJJk8gureCz1Yf1/azb/eMeVxFqIByuOqdMeVBrsi
        bjUZ1o44Hbdg5dZ3L2oC/76W8Sh3JyxnnjbVe/5wUA==
X-Google-Smtp-Source: AK7set/R4BiH/PF2hRbxzLizFVyNAKs4lvl4ii9te26TFCwaA12bbjRzIKdishRkQRMWInaP7gjjosZtyDFj/LVkRns=
X-Received: by 2002:a5b:38a:0:b0:ac9:cb97:bd0e with SMTP id
 k10-20020a5b038a000000b00ac9cb97bd0emr16155629ybp.5.1678696408073; Mon, 13
 Mar 2023 01:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230309225041.477440-1-sre@kernel.org> <20230309225041.477440-7-sre@kernel.org>
 <CACRpkdYTD3OZ-44N0oRD93gToxR_DoFSkLhvNjrRpCms2TX5nw@mail.gmail.com> <eaa72600-b85a-fa97-45ff-6412696682b6@gmail.com>
In-Reply-To: <eaa72600-b85a-fa97-45ff-6412696682b6@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 13 Mar 2023 09:33:16 +0100
Message-ID: <CACRpkdaHKZjkvZYM6GAnzXeRgfqFWE1aGMEqkN1HQ-3TX-DjtA@mail.gmail.com>
Subject: Re: [PATCHv1 06/11] power: supply: generic-adc-battery: drop charge
 now support
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Mar 13, 2023 at 8:49=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:
> On 3/10/23 10:29, Linus Walleij wrote:
> > On Thu, Mar 9, 2023 at 11:50=E2=80=AFPM Sebastian Reichel <sre@kernel.o=
rg> wrote:
> >
> >> Drop CHARGE_NOW support, which requires a platform specific
> >> calculation method.
> >>
> >> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> >
> > I agree. If we want to support this, we should use the generic
> > methods with interpolation tables defined in DT as well, and it also
> > ideally requires load compensated resistance calculation to figure
> > out Ri so this can bring any kind of reasonable precision.
>
> I guess you have your reasons, besides you have far better insight to
> things than I do - hence I am not really objecting this - just asking a
> question ;)
>
> Do we have generic facilities of computing this based on the DT tables /
> Ri in place(?)

Not yet, for the Samsung batteries I used a static look-up table
derived from the compatible string for calculating Ri from VBAT
and from that calculate the capacity from estimated open
circuit voltage, see
drivers/power/supply/samsung-sdi-battery.c

> I guess that we do need/see platform specific
> implementations as long as there is no generic "de-facto" way of doing
> this available...

The method I used with Samsung batteries is fine as long as all you
need to know to know everything about a battery is the compatible
string. Pretty much any Lion battery with a clearly defined product
name can be done this way.

The only reason to put the interpolation tables into the device
tree would be to support any random battery, such as one
that you do not know the model or this can change.

I am however mildly sceptic about adding that: if you know the
VBAT-to-Ri and OCV-to-capacity tables, you must have a
datasheet, and then you know the name of the battery product
and hence you know the right compatible string...

I think the right way to handle any capacity curves for any battery
would be to create static data like I did for the Samsung batteries.

Yours,
Linus Walleij
