Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A368F552263
	for <lists+linux-pm@lfdr.de>; Mon, 20 Jun 2022 18:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240977AbiFTQjQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Jun 2022 12:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243531AbiFTQjM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Jun 2022 12:39:12 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF13EDFCB
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 09:39:09 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 23so19930163ybe.8
        for <linux-pm@vger.kernel.org>; Mon, 20 Jun 2022 09:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=J6YCM3GGK2hsL7x+PaMSvF/YdxNaFbB33EhpPOoQiZE=;
        b=UdYUpqS6dQw7Bdkcj32xJ1fI8eLDtGWL5htYnsgxOCvdla9DAnsdY1xWnsnjTq27Wp
         Puu3EXy70JpD74hx1/Py8dmb6Jm/NXZyuhynvd+5j+YMl3pGBnUoiFcoKB/TZ6fBnRvM
         Kbh4COyNk/VwxQJHVHqzykTNgBye41I8JCOqe91NTSh1FQZbmYIvq0lqKkgG/SxJG+uK
         mmMP45iAfRPH5itK1EwTApjgGBMu+35yXTR1r1XpJihHt6T7ANMg0+uNrjQeaQSkBa+/
         vqhVz446WGG1BHygeautRcuB9DFxm120U4hFy9XI8s6TGfTlbNyabejvP2deLJjY/gxS
         glqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=J6YCM3GGK2hsL7x+PaMSvF/YdxNaFbB33EhpPOoQiZE=;
        b=qvBUkL5kGn71d+XFaDOmPHZmrVcweZ7jwHmXvIlf2eIY8C4nEXis36z7fqOQjEkbZZ
         8jXRnU0HGoczWBTe1QHcHrF/q5xjsEG1NYz4TcpJONV4cigo1nJksCAy3XjosSfi/ZSt
         LEHWscdQABXZuXG5uSHvyLbg/FC/Lpi9VvxQWK1dXbk9qP2N/TQLRTYSl2VLeYveVNSa
         1on1VUn/j81+eJcF8Y5AFPLIC0qMNC3d0MAUfXQoobXaz60fr5fiP2BlfYw2aNHWXXjR
         Sp2bulh4Ph0/2Cq+WsHFqLc3WJRY43QLk5Hc4HOyTxwzvqN3s/iCU7maMQGigi9fKR+Y
         Y/3g==
X-Gm-Message-State: AJIora9yOGBBllIPn2SYf+QpiGRkDSZWPm/tHpMqbUIFdQGmfBKLc2VC
        oXxEXbJbGBdHBQh2xyVe8CxEyrLQGzEbW23xKXM=
X-Google-Smtp-Source: AGRyM1uf0BmEtzsSrcCWm5D/IYFVANeo3WUYJrHCml79BpJusifvihclMumza8hNN1RRZ2jZZI7SWKl8EsEPT1EZP8A=
X-Received: by 2002:a25:86d0:0:b0:664:8657:fe63 with SMTP id
 y16-20020a2586d0000000b006648657fe63mr26330696ybm.460.1655743149008; Mon, 20
 Jun 2022 09:39:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6918:704:b0:c6:5e36:6de2 with HTTP; Mon, 20 Jun 2022
 09:39:08 -0700 (PDT)
Reply-To: michellegoodman45@gmail.com
From:   Michelle <michellegood044@gmail.com>
Date:   Mon, 20 Jun 2022 16:39:08 +0000
Message-ID: <CAJ5e1jZEWAOZ2+FDouv9GLSj1vGrOSiMWgz1DzBctnTHMMGGqQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dobr=C3=BD de=C5=88, d=C3=BAfam, =C5=BEe ste dostali moju spr=C3=A1vu.
Potrebujem r=C3=BDchle reakcie

V=C4=8Faka.
Michelle
