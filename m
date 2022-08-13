Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0615919EF
	for <lists+linux-pm@lfdr.de>; Sat, 13 Aug 2022 12:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239339AbiHMKuC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Aug 2022 06:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238945AbiHMKuB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 13 Aug 2022 06:50:01 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0003AB34
        for <linux-pm@vger.kernel.org>; Sat, 13 Aug 2022 03:50:00 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id d1so2339243qvs.0
        for <linux-pm@vger.kernel.org>; Sat, 13 Aug 2022 03:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=i0pV8wBz1W0BBOd4LyB7Iju4x2bMHNjbBYv8Ry5TkMlj88najietdsz2C0r6Lz1erv
         MJIx4DI/AXeGG6/l4HdDWYjk5FNIHULZJ2rB8CcL1XCslS7KuAm9C7jDsR1fzlC52lpw
         TmbWS5tbDxB4CnYU+2F65CLW/Z4pPYTaMBno3CI6LWyiOwX5JfR5DNj0CzhmkF9nQZWB
         usxLsiUMRfkCPi5XMq6/nULCn8dpvOrr4D6r0uuSlnV3/kELQjuXdiN0nKXXnmAhsqJ+
         e3FmAf3fPxYaZRsH3paZlBjOb6uJkLXEb8aSAMm5aIqV7ooBCHrH8oIAq3ez31hd+1T4
         J3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=mTe6rsF1WlocKfWRCIawejpNJl6lRYSIlYxDz8jltlQ=;
        b=PLqzS68diyoa+cUI8be0zyhSE3RRss1hB3MCxWWA/W2Op38oG3pGVpLyTzQUCsF2C5
         PRbs1JwD6OkuCrH2PNbjbIFbZK2IgL9mTGUR+kfpbfT23jBXN7E5sXrZIg7UDldmb0Ht
         kYNp9/W9oPnsDrrp1v4HPnMTk7kM4TC/e1pI2klVfWjnfsVYhvCE8zErEXq37N29cX95
         zyfJwNPFdQnFIxOZJpuBQLuu0r0kjdl++nToR7tDZHzUegTLfHBbjOWU+6Y/GYDGxrxj
         EnOE+ji//4rYMjvdQWdR6RWiNPlbayujWV90+t6oDmH9FBr6D2TQHTqlmY/2Q8CVb4bg
         ISQg==
X-Gm-Message-State: ACgBeo1vN4fI2INERLrs4t9hXML38Bwc424O1UP72JWzfYOuNdJOarir
        /r7KCiqNW8HvurRTPtl787y33KYP5ngAbmhS8Kk=
X-Google-Smtp-Source: AA6agR7fnJek74F+p7dr+4YNVGhiq0Nysw5RO0wTeeg0YXhgOCLEPEiNpsB+D8QmP47OHAh1H/PQDC0DBX4mJ+834I4=
X-Received: by 2002:ad4:5d69:0:b0:474:8b29:b257 with SMTP id
 fn9-20020ad45d69000000b004748b29b257mr6788675qvb.80.1660387799869; Sat, 13
 Aug 2022 03:49:59 -0700 (PDT)
MIME-Version: 1.0
Reply-To: zahirikeen@gmail.com
Sender: aliwattara123@gmail.com
Received: by 2002:a05:6214:21e4:0:0:0:0 with HTTP; Sat, 13 Aug 2022 03:49:59
 -0700 (PDT)
From:   Zahiri Keen <k78754399@gmail.com>
Date:   Sat, 13 Aug 2022 10:49:59 +0000
X-Google-Sender-Auth: eeP1adH2j1b_2PUHq84R2EyZzLg
Message-ID: <CAHToVsJmK4amSz=TjO97OF9xNz0BL17Zxpmcq7xv+ZG0T1t6fA@mail.gmail.com>
Subject: Very Urgent Please.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Good Day,

I know this email might come to you as a surprise because is coming
from someone you haven=E2=80=99t met with before.

I am Mr. Zahiri Keen, the bank manager with BOA bank i contact you for
a deal relating to the funds which are in my position I shall furnish
you with more detail once your response.

Regards,
Mr.Zahiri
