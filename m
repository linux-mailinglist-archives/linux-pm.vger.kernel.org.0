Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F2F55AE56
	for <lists+linux-pm@lfdr.de>; Sun, 26 Jun 2022 05:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbiFZC6M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 25 Jun 2022 22:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbiFZC6J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 25 Jun 2022 22:58:09 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BF2766A
        for <linux-pm@vger.kernel.org>; Sat, 25 Jun 2022 19:58:05 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id u12so12204496eja.8
        for <linux-pm@vger.kernel.org>; Sat, 25 Jun 2022 19:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=aT1sw4m4Agr0F5UoyxxRFIViLo6ffv+TYGmHogSjXGo=;
        b=p/DaixlYtjrJxt0TZ9Sv0PspLH4F4gpAQfDxd2T6KqC1SHP9iljS+DwZTMfPiVSSGm
         F/yNzbwcX3bzuMK/1r8IAdidUXoNi472FD+5xEchiaxU5Sq/f4nUM5bs2KzE38nQDDEZ
         xSboCrjSiM+wm/jrg/92deA9oYzxIYEuFDC4v6npNzzWb+JsMCzxVQlhOP/J5Ouy0uLi
         Z7+yA39BZEdGRUHmW3xbx5TQB4S2VCry5+wcWHVQ4OBH4rBTSMkxbT0Jgm49FOL7iNyZ
         eJjfuW2I9E7w0ML0yN3iKNPtc1B9yptX2/H88HdKh8PtQprUzdCaXhiksW5fAtIU0eIH
         t/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=aT1sw4m4Agr0F5UoyxxRFIViLo6ffv+TYGmHogSjXGo=;
        b=gKSXFq9ndTFH+QQs38HgbYK0uC9TbK2zsdECQRN1ucdPAQ89ultA3+mZzJLiTmaEW1
         vWyHftmUduL6CdE5toacOEEue+BFxHpE/E0KdykiNUr9tuJkOUSoZ+7Syyozby6pthrO
         LrhD6K/Tik894gtc7umKnHFPHrTnkj1IE50DGjAU10d2W4ytIF6VmxUZlzJpaP2IqjLb
         PhSMlU8SVxLnVNETBy2WPr7i1UIVymOAe+JaJQ9kn5j8zTtaORUlPQOUxylHNFWzhcuJ
         6rld4+q0PwKYp00AQTp4ec73HPZoffNXfOyskRwuy3qVRGVGIRrIB89LpoIsefsuo4EV
         XpNg==
X-Gm-Message-State: AJIora+ATqNvpbwqjT4oQZZL+N4D+4HkDd46RwzHf5td148IWyI8GBWm
        BDL4UowJ2hir0QXk2D5FYegQ8DNsFCfGgfdoTiA=
X-Google-Smtp-Source: AGRyM1ugSbCDNnHpCb0lHalta+66K0E8Up9pyta5m/WjutEeClM5wDgsnA3eyhUSaZXFZvkZaFOFWCa0CuHHdyv6tMw=
X-Received: by 2002:a17:907:2cc5:b0:711:d50b:287a with SMTP id
 hg5-20020a1709072cc500b00711d50b287amr6181154ejc.47.1656212283268; Sat, 25
 Jun 2022 19:58:03 -0700 (PDT)
MIME-Version: 1.0
Sender: jerryojomah@gmail.com
Received: by 2002:a17:906:7306:b0:6ff:31c2:22be with HTTP; Sat, 25 Jun 2022
 19:58:02 -0700 (PDT)
From:   mrs marie brigitte prouvost <mariebrigitteprouvost332@gmail.com>
Date:   Sat, 25 Jun 2022 19:58:02 -0700
X-Google-Sender-Auth: kxr1f60VkmaWOTB8ethgMxSh3l0
Message-ID: <CALqLPnenBJaHG2ho-J_j2WZA+Mx98T=PMFWK0Zefx=rNSkwZ6w@mail.gmail.com>
Subject: Dear Old Friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        HK_SCAM,LOTS_OF_MONEY,MONEY_FRAUD_3,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

-- 
I know you may have forgotten me, I am very happy to inform you about
my success in getting the money transferred under the co-operation of
a new partner from Venezuela.

Presently I am in Venezuela with my partner for a better treatment; I
told you that I rather die than to miss this opportunity. Meanwhile, I
didn't forget your past efforts and attempts to assist me in
transferring the funds despite that it failed us somehow.

Before my living Burkina Faso I left a complete sum of Nine Hundred
THousand Dollars,
with the western union money transfer to transfer to you as your
compensation.

Now you are to contact the western union for them to commence on your
payments, Ask them to send you the Nine Hundred
THousand Dollars, which I kept for
your compensation for all the past efforts and attempts to assist me
in this transfer.

Here is the Western Union money Transfer section

Email. westernunionmoneytransfer.WU@financier.com

Remember I have already forward this instruction to them and they will
be expecting you to contact them to commence on your transfers.


Bye and stay bless.

But never forget to inform me whenever you received all your money
because I have paid for the transfer fee.

Thanks and God bless you

Sincerely
mrs marie brigitte prouvost
