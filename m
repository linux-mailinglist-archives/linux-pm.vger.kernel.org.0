Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 059755B5FAD
	for <lists+linux-pm@lfdr.de>; Mon, 12 Sep 2022 19:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiILR7G (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Sep 2022 13:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiILR7E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Sep 2022 13:59:04 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BE42CDD9;
        Mon, 12 Sep 2022 10:59:03 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id g4so7332091qvo.3;
        Mon, 12 Sep 2022 10:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ht1im4tB/1eWEdoLllDj54jgaAy+Gxz1qnZPXQgNIzU=;
        b=Dt3H+mlxYZHpbPBK8odBCgz7iysVydGNc/lKmnGaCGv6H8/5FU+SvUR0TGA/W8OY5x
         Rhl1Mpz2CqCGSwUrD2utGR74dBQC3uxsMpCRbqpekmDOFQ10PNUZD/mJLMi21sKucoI5
         vdtkb67oExC/9UD0DpcPeG5qgwX9xgybJ3+RohvSQQpEOs19orogp0j+XIWK0V5vdWMO
         WPhX25ZotJhcW+KjEml0CQmvBsSgQy8VObUStrJ2uBGA5zTpXS4nRq8QYHdMv9AUBfYt
         jRJ8nqYl3Kmk6nWvoXv5W4ED0uyOgQh/2b+IrMcRkMGuA5gjQXqXImjPiHbGPlGiCAKM
         I/yw==
X-Gm-Message-State: ACgBeo1+rpCfONveuzSGNGUzqJVlYaJX3fQodJzNT4nnjso0sBCzBN1O
        UaolkX/zP1Uqu6eVN2nonPWqhwsWCaBeOA5+
X-Google-Smtp-Source: AA6agR4PqCjY0PJzn64LtAoYi+cB3s8uDQ5uTJL4EU/hiO/dmXkoG48dqnZjVCFbQv+7A6tQOPHyrQ==
X-Received: by 2002:a05:6214:c82:b0:4ac:93e7:62dc with SMTP id r2-20020a0562140c8200b004ac93e762dcmr12233253qvr.53.1663005542956;
        Mon, 12 Sep 2022 10:59:02 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id g21-20020a05620a13d500b006b9264191b5sm4169929qkl.32.2022.09.12.10.59.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 10:59:01 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 130so13985552ybz.9;
        Mon, 12 Sep 2022 10:59:01 -0700 (PDT)
X-Received: by 2002:a25:69c6:0:b0:6af:6f10:9d50 with SMTP id
 e189-20020a2569c6000000b006af6f109d50mr2491654ybc.543.1663005541054; Mon, 12
 Sep 2022 10:59:01 -0700 (PDT)
MIME-Version: 1.0
References: <DU0PR04MB94173B45A2CFEE3BF1BD313A88409@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAPDyKFrzJikk6rJr9xwV6W-whvdLe5tTUE+xO_EoRtm+9DAbNA@mail.gmail.com>
 <20220908173840.rqy335cdeg5a2ww5@bogus> <CAPDyKFqYDNXxfKHd8PYy8T3di2s206nCiHY7cEf+_EHVrY1YbQ@mail.gmail.com>
 <20220909154254.xy4jvj6ybpuynghc@bogus> <CAMuHMdXvTWvZHjE-7CKOxCKjuPF++xQQRGedHeL2Zy-wsnHviw@mail.gmail.com>
In-Reply-To: <CAMuHMdXvTWvZHjE-7CKOxCKjuPF++xQQRGedHeL2Zy-wsnHviw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 12 Sep 2022 18:58:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX2rJq0DJo9D_RSMoAj9GPc-Zts5+UNCFQGF3+EYVSXgQ@mail.gmail.com>
Message-ID: <CAMuHMdX2rJq0DJo9D_RSMoAj9GPc-Zts5+UNCFQGF3+EYVSXgQ@mail.gmail.com>
Subject: Re: Question: why call clk_prepare in pm_clk_acquire
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, Peng Fan <peng.fan@nxp.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "jonathanh@nvidia.com" <jonathanh@nvidia.com>,
        "npitre@baylibre.com" <npitre@baylibre.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Dien Pham <dien.pham.ry@renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sudeep,

CC Dien Pham

On Mon, Sep 12, 2022 at 6:49 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Fri, Sep 9, 2022 at 4:51 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > On Fri, Sep 09, 2022 at 01:12:03PM +0200, Ulf Hansson wrote:
> > > On Thu, 8 Sept 2022 at 19:38, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > On Thu, Sep 08, 2022 at 04:37:13PM +0200, Ulf Hansson wrote:
> > > > > On Thu, 8 Sept 2022 at 09:33, Peng Fan <peng.fan@nxp.com> wrote:
> > > > > > We are facing an issue clk_set_rate fail with commit a3b884cef873 ("firmware:
> > > > > > arm_scmi: Add clock management to the SCMI power domain") ,
> > > > >
> > > > > Hmm, I wonder about the main reason behind that commit. Can we revert
> > > > > it or is there some platform/driver that is really relying on it?
> > > > >
> > > >
> > > > IIUC, at the time of the commit, it was needed on some Renesas platform.
> > > > Not sure if it is still used or not.
> > >
> > > Okay! Maybe Nico remembers more, as he authored the patch...
> > >
> >
> > May be, or even check with Renesas team who tested his patch.
>
> I'm not aware of Renesas platforms using SCMI...

Upon closer look, Diep Pham did report a build issue in the SCMI code, so
perhaps Diep knows more...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
