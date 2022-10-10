Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA22D5FA11B
	for <lists+linux-pm@lfdr.de>; Mon, 10 Oct 2022 17:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJJP0l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Oct 2022 11:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJJP0l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2022 11:26:41 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449EA70E6C
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2022 08:26:40 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id m81so13054546oia.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2022 08:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QCoe+CZE7zJGjtNkHsm5KWTS6304coK7lHPuljPWFPM=;
        b=cE20AuLGJYATKgenhpF/Q+zEPn2QnXSFhpsOb42hImh/sIVMblNZfsiaQMRu/v+wzb
         lB4CTsziNNXu769GHn5Lo1Uk5Xpm6EkqeIs/TjQhm0ipSUnp0cXvBUxiNX5fdNJ8Hj+9
         wHps0aLaJ4MwUQ5F0R9BD7o6piWJw8WnTUQstPNNViUOhsgEe/OYjRdYQLW2WXfUW2Qs
         oZTas3pxNA7MaowkiIb+YtbkpyG/xyLtE2tRGlw76eP0dqcFrxXPDPJ+JOH0a1Xt266f
         dPvwLsaI0BMZn/GEgpfa3nCmHO4kL0cKinJualQj2UHrW/F+zqD/8SJZdyDvcLYxOdaC
         Ze3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCoe+CZE7zJGjtNkHsm5KWTS6304coK7lHPuljPWFPM=;
        b=La8KTIeB5nmfb3mQoGkfU2bbVxRXPFPAbXlcT+vVUFdg0Alm9gb1Maods6ZKraJNyL
         89GmWPYskRq1fZ3tg6VliCvIy/75tYwP4+lZ6MSwjRuOKz4F1FMkH6jupVUfU3Qt8Qw2
         DbxF3VeMj2eTPEBWWA/qJxUIYi9IM2pFKVp/Flbgg1kcZKMOLNkXcml/50pQ//n1PToO
         U2ej31YhkwEbQULj2feIGf5pkf2A8dsllaytjdahCA5rul+Il7abZ7+jMj3NtcZgd4ee
         O9eI0/7xorh6f6TkqJZXP31loN3xnzJCAvapr6CNEfNlflgj6PIBwnNegXSohpLW7I1T
         fZuQ==
X-Gm-Message-State: ACrzQf1bDzAmpbQ9GAV0cQ8HUYjVv6zfGtv0ntSYmiMoWDxq4aiEZJnn
        OBoIrpoFRTm79YLq5kFG82J5eWLecYfesAfMurI=
X-Google-Smtp-Source: AMsMyM4plfYVb1IPgNyW4G7VQd+AO+MAfGBxP+GusfpUoidkfpdh7aEXZheoeTe7GwCuT/oyAv3Np0+xVnh4+//p54g=
X-Received: by 2002:a05:6808:1444:b0:350:aae9:3c1 with SMTP id
 x4-20020a056808144400b00350aae903c1mr13829797oiv.227.1665415599515; Mon, 10
 Oct 2022 08:26:39 -0700 (PDT)
MIME-Version: 1.0
From:   Lillian Zoe <lillian.salesservice@gmail.com>
Date:   Mon, 10 Oct 2022 10:26:28 -0500
Message-ID: <CAEPeTTiWBt4iiZWbGFAha1R4Ms9p6N2Z9raqM=hv9PhUr-YbMA@mail.gmail.com>
Subject: RE: MJBizCon Attendees Email Lists-2022
To:     Lillian Zoe <lillian.salesservice@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I hope you=E2=80=99re doing well!

Would you be interested in acquiring MJBizCon Attendees Email Lists?

List Includes: Company/Org Name, First Name, Last Name, Full Name,
Contact Job Title, Verified Email Address, Website URL, Mailing
address, Phone number, Industry and many more=E2=80=A6

Number of Contacts   : 25,458 Verified Contacts.
Cost                           : $1,659

If you=E2=80=99re interested please let me know I will assist you with furt=
her details.

Kind Regards,
Lillian Zoe
Marketing Coordinator

To unsubscribe kindly reply with "Leave Out" in the subject line.
