Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F718591BB9
	for <lists+linux-pm@lfdr.de>; Sat, 13 Aug 2022 17:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239888AbiHMPuf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Aug 2022 11:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239843AbiHMPud (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Aug 2022 11:50:33 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6727FE59
        for <linux-pm@vger.kernel.org>; Sat, 13 Aug 2022 08:50:32 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id q19so3373899pfg.8
        for <linux-pm@vger.kernel.org>; Sat, 13 Aug 2022 08:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=AM0GRioucOrzWHO4p0HR2p8Wl1Io0HB/IprsOmmvWsk=;
        b=jRp/vWNNTUkuTC4tYqzF79U/ftfSRrtIxUpyMdsDkK7TRBIflSVScwP1BUe/V97wr2
         irv8nB4ksFnLlTwPXjFzdqq5bfqCRMJkMYfQOgaxPW49lQjJ36fWEm1+qv3/k4eYE6WG
         JXe3JV/bv2OxJnAKE4mefbT4LJ2/DlfctWMS4QAVEy1e83O6TT3Y6sn/q/k/YgqpEnha
         rNpPVgv9HtOLOGxScJ798A+yNy0S8E3G8hj/Om23bXqkVeCiJNTM/lgz3Sr7G2H2Ku5S
         zj8UJVvSjgUvkk25S4MlPiFe1L0X3qyDelQF/Fe7SOmyMQ7hyV+GOAWZg76DNyNm7pZd
         0DNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=AM0GRioucOrzWHO4p0HR2p8Wl1Io0HB/IprsOmmvWsk=;
        b=w88b5WSyxefMBm+SK5EnfCx5qqNGL34cYoevcKdws8/ggfSl7tWDEiqc9kQKvA63KV
         tVMTRtUGye9RGmPtoWpiAB0yyfm48yb/PEsxnhT7MF40vdK+/RpXxrZqOH2gB6ZX/NOs
         o7p0rinhn1XEc/Kh3pLym0H8yAsaIWm7K4HjDnmFFRaWfHnE4+PY53Br8yvxDtH1vFoo
         lmD9gT668Ymjdkmm9+Pde7fvqFFwpNZU6GCfY7aOf/i1p0IMhThjYBWAU8VdaL3JyboU
         GVqMxwaINyfENZJtEvDoGcr+aihbmUxCTVpV4cy+57s+WnTkPGAdvybvIJxxDhcDmGfU
         wrMw==
X-Gm-Message-State: ACgBeo1hupb6v7Z9fpThheNyMhqUSnhBAGH/Sq7WOmEyljKtj4KtDlWx
        pdLg0QQLZpBBPiz3+glcN/QJ+/y/YR8d8ydtlmU=
X-Google-Smtp-Source: AA6agR59dsw9bJfzhoMO6sL0Zyx02h+3r0ZqOoNxGhpyl6OhY4UPOvWg59tgkdCVTsXuw/fPoB1w0CHtYnH4jWVRXDE=
X-Received: by 2002:a63:2110:0:b0:41d:234f:16aa with SMTP id
 h16-20020a632110000000b0041d234f16aamr7066136pgh.481.1660405831951; Sat, 13
 Aug 2022 08:50:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:430d:b0:6d:2c13:7fde with HTTP; Sat, 13 Aug 2022
 08:50:31 -0700 (PDT)
Reply-To: wen305147@gmail.com
From:   Tony Wen <weadmn10@gmail.com>
Date:   Sat, 13 Aug 2022 23:50:31 +0800
Message-ID: <CAJ_Onsjnwmq5B3=4XkbNVbv43+nRUwefQ7BpGq2h=ELw4P-PqA@mail.gmail.com>
Subject: work
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:42c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4910]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [weadmn10[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [weadmn10[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [wen305147[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Can you work with me???
