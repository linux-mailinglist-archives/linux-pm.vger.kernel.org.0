Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B9B535943
	for <lists+linux-pm@lfdr.de>; Fri, 27 May 2022 08:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245192AbiE0GZO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 27 May 2022 02:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245156AbiE0GZN (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 27 May 2022 02:25:13 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE57F25C4A
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 23:25:12 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id s23so3697452iog.13
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 23:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=33H7bzlF73boyoKARvolMJlGymprQ+hHPrvlaQBxLsY=;
        b=gBB/cwiGfmHtke5+MVOg1U2wNWTEr120LVQWK908/OVHr82Ivoq7Un0O2mD3i6fHG6
         OThBqoy58hxFvilear3j/8YpPiFgIwr7tS/3KTeoverlG/LeQgwhL0Kn3HQRKWfaw1lA
         koqCWfHlLrIMDArNXeq7xC7YU67zXwUHiaeMwRRU9R0k72+LrMpRoasCvZL2CsC+qqfm
         jK3L+mfY9L0ohvfGZ1SV4+uxJ1Lr2ItAafFfZP98LBKdqEyVJ1KSvjDBqr3Pg8UK+75p
         vpdeVhnaRT3FfhQBH13FUh+ppuPA+VKMIMeMy4whpYxjLkLs/mshrzwW7oEzFoqJxV5h
         5dVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=33H7bzlF73boyoKARvolMJlGymprQ+hHPrvlaQBxLsY=;
        b=bIiZfgKMOyzXtFakUO78vG0fNQTJYuIvZYYdpklw+m2Ragr9EXKLP4jR8QmBsVds7E
         G5jobbb4hXSEHLfK6H5QjQV28YxAFTXzuzN5aY5dtQPK31KLoUaVU11Wn0Qtw0g6By/C
         nRR3GQqyIHmB6Gg6vRS1M/FN/Q+N69n4dZpdcLm/aD9ASOFaiJLiZac8kj4H4jjDerAF
         84S3GhSzvpAR6dUqU9gIipokLBO2+zM11+UQyg7/zapa3YvsjmK49mmbMSCLSYvAxypM
         LojK0mQGgQHxi2BQPuyrNhpqQKxUrKqqMEv3D/HlIIA/1UQbzBgXl71oFyMM7rnve1it
         NNjg==
X-Gm-Message-State: AOAM531kXfOVL9oL2qKriK1reKu+nJrmyFJunDKY7GQzfMwv4GHQMi+J
        iSthmD025rNqgVYMn2AJ/gSDkyQX4KMeny6y3oM=
X-Google-Smtp-Source: ABdhPJyuSHQEY2A3k4hHTnJvScNnCsm2HeGVpawtkPs2YKwiTHyvgOhOCllSaVK2jiAKtmi8tOuzQsZIg0156fnaTJ0=
X-Received: by 2002:a02:ba05:0:b0:330:f166:d90a with SMTP id
 z5-20020a02ba05000000b00330f166d90amr1303825jan.213.1653632712131; Thu, 26
 May 2022 23:25:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:388b:b0:32e:cca7:1993 with HTTP; Thu, 26 May 2022
 23:25:11 -0700 (PDT)
Reply-To: IREnnewilliams@gmail.com
From:   Irene Williams <lori.robinsonnj@gmail.com>
Date:   Fri, 27 May 2022 06:25:11 +0000
Message-ID: <CAD13ymaBeqKXgvfD_u2UWxZXj13uKaxNUKV4O4o+7kCc4JFEuw@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello,


I wrote to you this morning because I have something to tell you, please
let me know if you read my previous post today.
