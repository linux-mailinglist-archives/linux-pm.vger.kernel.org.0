Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B1A701889
	for <lists+linux-pm@lfdr.de>; Sat, 13 May 2023 19:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjEMRjY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 May 2023 13:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjEMRjX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 May 2023 13:39:23 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D88E0
        for <linux-pm@vger.kernel.org>; Sat, 13 May 2023 10:39:22 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1aaff9c93a5so76415035ad.2
        for <linux-pm@vger.kernel.org>; Sat, 13 May 2023 10:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=goody25-com.20221208.gappssmtp.com; s=20221208; t=1683999561; x=1686591561;
        h=reply-to:date:to:subject:content-description
         :content-transfer-encoding:mime-version:from:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJyK+zny8G6h/u3TNzihOttGw2H5y4rBsd6pNLP7HMc=;
        b=ckKbDcjAalZxQwmrLVCFjjLaEZ8Sszoj2yQW2XX9iEE0FoJzTlKkeZPedLPvTuKONz
         zz43VDXBKpRERotFb7jh/iE+bs5tomyEnTM+wcUATr6nmpkR1l4/T8GDoObMmyB80ifn
         sWn+OFAh7lCLLtiO51hvqp1a5VvplHKc+EEs80ES41i2tw2HpRLrVd0bg3I9MZUH4Zls
         7Gcvg3/G8zzFWkJ88c45l8JPIBx4SNoXedH1uh96DdwuYfeX8mejeeYhIONhJZhpjE95
         dZxBZJy8ywk/KjlmZhUbQ3u+ee8jA+oAjz89Pm1momUVsh7ogPRE0eldymzWK5MU83fg
         IvHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683999561; x=1686591561;
        h=reply-to:date:to:subject:content-description
         :content-transfer-encoding:mime-version:from:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jJyK+zny8G6h/u3TNzihOttGw2H5y4rBsd6pNLP7HMc=;
        b=V5jZ74L7HOIsXSuV3RYrFqoGAu+FOHW54riK0k9G9xjI70AyPBGdgiq8dxWSGGfoKF
         2q6h+tH1SExe1kE48Qq7x0iAPVlOoDtFm36pdh43ze73+f1Apo6lyZQLZeflDa3BYQqZ
         hiTuaWXVyq1WD4rfZMlM7shgRY+n1pK1HKrdLAOX+hUCaKf3LUzGWkJ3sAqztn+748lS
         b4P3M3MCt65pre76f8Bvmg0yqjQ8MYf/DXgJDKrLggZwpnEqJv82jU+/cKz7e/ZomEjL
         b2fwLPLMlD0M7SnCJVdDPGZmsajCqk7xPbNeC+cZqNo4InrVQ6L7HJlpOBn0p5SsypBv
         tXQw==
X-Gm-Message-State: AC+VfDwYO1mpv17gaUo3Gs8VPH0lJo+mY17htqI0oe0hVOs+G1us2JTG
        Ew/h6f/FmqU0PUiCKHm7XWWCng==
X-Google-Smtp-Source: ACHHUZ5Z7bSxJGo/H22pPCe28QVKOIX9EkgPy3+6a+tWPJALdnlnhZmcQeCWa45kILOw+3y6LbpSJg==
X-Received: by 2002:a17:903:22cb:b0:1ac:6e1f:d19c with SMTP id y11-20020a17090322cb00b001ac6e1fd19cmr28122913plg.41.1683999561620;
        Sat, 13 May 2023 10:39:21 -0700 (PDT)
Received: from [192.168.1.5] ([149.18.84.31])
        by smtp.gmail.com with ESMTPSA id i9-20020a170902eb4900b001a1b808c1d8sm10044699pli.245.2023.05.13.10.39.16
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 13 May 2023 10:39:21 -0700 (PDT)
Message-ID: <645fcb49.170a0220.1dc98.41e1@mx.google.com>
From:   Li Yong <support@goody25.com>
X-Google-Original-From: "Li Yong" <liyong@cnooc.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: This is for you! 
To:     Recipients <liyong@cnooc.com>
Date:   Sun, 14 May 2023 00:39:10 +0700
Reply-To: liyonng2200@gmail.com
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Good day!

I need an individual or company to invest with. Please, advise on investmen=
t opportunities in your country.

Reply for more information.

Best Regards,
Li Yong
Vice Chairman Board of Directors
China National Offshore Oil Corporation (CNOOC)
