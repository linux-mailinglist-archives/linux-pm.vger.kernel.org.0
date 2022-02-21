Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851FF4BEB96
	for <lists+linux-pm@lfdr.de>; Mon, 21 Feb 2022 21:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbiBUUKh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Feb 2022 15:10:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233449AbiBUUKg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Feb 2022 15:10:36 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4AFBC2A
        for <linux-pm@vger.kernel.org>; Mon, 21 Feb 2022 12:10:12 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id j24so9918144oii.11
        for <linux-pm@vger.kernel.org>; Mon, 21 Feb 2022 12:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=wNS6i0JkwH6rl5Cb/oQjjWAuKKUfR/NgAywIYY564Po=;
        b=NcjCkKUHm3TXJMx2nLIjaR8Cey/6abFscAbOYOV2U01xqK51xVKFEDsxJIKYVtL1gQ
         JBXkGPSMZ1Zc8hNAeF6c7Zb4rF7rkJSFvmNTYCs4RtDzC6MVRtptPIypQvvfu0DV5s8x
         +H1cyuAKHUDpfQ2dxWooj0jqYhj4PLCxtEtSqGZC9s7+SIbs09hkGvr0/HtFRqGjEmIS
         7MjBbNkwIBmnbrkRrIhstR7xqSFtHSzpVJH+nSPYUI6NerRjV02U2Fo6AxNte6X3GYJl
         cHDVsfWqCaHCKSqD5KisfTpM55dHGK5LgB71pDKNHEWiDRiOnVS9kxfDJmpfqUVQLPAd
         WhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=wNS6i0JkwH6rl5Cb/oQjjWAuKKUfR/NgAywIYY564Po=;
        b=PLqTyWztQj/JeVE3xZ4ioorKSrcjCg0Hd4+W0tSC8edGgPc8wqEm4w0zwu+XF7KAsy
         4FdWSg2VRYi+KKomuT/IlW3amn9BS1bkFg/53XKIfMrEJ9ZNUJjPhe/Bi2gZypYc/WKR
         Mk2d7asDVWHntwhBVw+anc9pBFECtTt/Y1zfKBpn87DSO5nkRcou9kxeunUOyVwkSIjK
         EPdhzs4B5+iBABYoKUdeKNv1lGFuYbBT9rAoy8NhEAiOrFTYG8PkYus5F7IUjVkb/KvL
         NaiJ3dEnpoNnIVcwS216p7a7dDOTifTwBggnSEABgGl+5uJLXyWjxbBgPDC2P51OslD2
         BGkA==
X-Gm-Message-State: AOAM532N5mZlKlJ4m2KqapdkRSPWdVNqqxFZqgeVix3GtDQ9y/Jzmokz
        V6Agmcda04srh/6tUs9gLGWijzsz2+8f1C7d2KQ=
X-Google-Smtp-Source: ABdhPJzUECjCjfRpFfN0TEuaM7rfbSd3rKmuYm3bOwGtENYYuP/0hnXsqFEoarc8e6PSkjMjgg/bqEqArfo+k4GaB9s=
X-Received: by 2002:a05:6808:1a18:b0:2d3:a839:9a63 with SMTP id
 bk24-20020a0568081a1800b002d3a8399a63mr328628oib.49.1645474211772; Mon, 21
 Feb 2022 12:10:11 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a4a:c70f:0:0:0:0:0 with HTTP; Mon, 21 Feb 2022 12:10:11
 -0800 (PST)
From:   "Capt. Sherri" <sodehoufiacre@gmail.com>
Date:   Mon, 21 Feb 2022 20:10:11 +0000
Message-ID: <CAAWnXvuhLOZYzXfi4AUGtDp8=BTZ4=RUy9-VTnTxRiBGq9Adtg@mail.gmail.com>
Subject: Re: Hello Dear, how are you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hallo,

Sie haben meine vorherige Nachricht erhalten? Ich habe Sie schon
einmal kontaktiert, aber die Nachricht ist fehlgeschlagen, also habe
ich beschlossen, noch einmal zu schreiben. Bitte best=C3=A4tigen Sie, ob
Sie dies erhalten, damit ich fortfahren kann.

warte auf deine Antwort.

Gr=C3=BC=C3=9Fe,
Kapit=C3=A4n Sherri
