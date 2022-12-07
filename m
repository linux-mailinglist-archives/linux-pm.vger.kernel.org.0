Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB700646190
	for <lists+linux-pm@lfdr.de>; Wed,  7 Dec 2022 20:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiLGTVN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Dec 2022 14:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiLGTVM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Dec 2022 14:21:12 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4674D4AF36
        for <linux-pm@vger.kernel.org>; Wed,  7 Dec 2022 11:21:11 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id i186so11835243ybc.9
        for <linux-pm@vger.kernel.org>; Wed, 07 Dec 2022 11:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhbT+I+m/j1zIBMdGQ5YCdD5f5II+ZRqGX/fHpao/tc=;
        b=E6XbPyMMyzh6c5i7+KzMNUGHkJoT87gKjt5glCORgv9em1NLWHnr1dWXQDHMEf9mS4
         ekIBFtgDiQLLAIEXBuFFiBDy2s6IXunHoicgwcf8GivhnLLORErbQTpEG/i0rnnfv6dp
         GdRqlh++WcR2WnfldDx68C/KgjWnlmW1DAIwgXIfutZO6cou+Nt0Z/t26b11jsFqT/9t
         VGkMYIWAf9iXsn6e0WGsmU4SncQZUv87ILBER6oI8FXyHeGI5gz0Up87izSeBYMG41lp
         jY1XXL9OtxMtMLgD2uRGMDwCXSUbjrmpe9jbC7leqhsdYF5J3uFDHYMe8qY7CjkcvsEf
         oIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VhbT+I+m/j1zIBMdGQ5YCdD5f5II+ZRqGX/fHpao/tc=;
        b=3yBi+Z2xQmpuU5OdOsTB4OXVRIkO/HPb6rDluQTpaiYdARK8+0+UyF740yhLblMX28
         KAEKhS3hwySL+1MpVlKw7twBZvtuOBWO78emyty6N4OldTExo5J3K52i3HHT/fpMamA6
         +IB7ttjQ+hAlyWCKartZNtqXG3Icpb+PtEkdo+elxxHbFLGcY/AtqeWHP1T31/65tnTG
         ss+E9zm5LCMpcWXlYGfD9+NUcHMfjyAy5RFBeoRjBzbwT6KAxJ1bKjK1gOAtno+VYauw
         /KO0SGZ/w0fIrhYf+PGZfPjtKjYhXXmxZfB+jfmqPXeroDSNrJRdZimH7Tg7PVc0mnqR
         wUEg==
X-Gm-Message-State: ANoB5pkEoo44IOBgCUW2ESgS6ap/Nr9aD5LaDfSZSHfDhKI+gI0ecENJ
        Es0IvOocXM+1xeD55QD6ZhdDR3DGKfDFqd/q0Zc=
X-Google-Smtp-Source: AA0mqf7jxKb20hB2O3vFeWPk1p4Kiy0qJT9jC7ciZyzkqhkT8EDqlGWF5iKIUKMyPMtk8aj1llbaO5qL1HtMVXvDDRg=
X-Received: by 2002:a25:a45:0:b0:6fa:4d0f:a743 with SMTP id
 66-20020a250a45000000b006fa4d0fa743mr33911542ybk.35.1670440867885; Wed, 07
 Dec 2022 11:21:07 -0800 (PST)
MIME-Version: 1.0
Sender: mrs2018sabahibrahim1@gmail.com
Received: by 2002:a05:7010:8fa0:b0:313:81c4:2aa0 with HTTP; Wed, 7 Dec 2022
 11:21:07 -0800 (PST)
From:   Elena Tudorie <elenatudorie987@gmail.com>
Date:   Thu, 8 Dec 2022 00:51:07 +0530
X-Google-Sender-Auth: 7wLjXN60YPYq0aS-wVf9StOtJzw
Message-ID: <CALSDefmnvufi4vw4kDJ-wYG-X15LxNo0DHgOWb9h55AN-angig@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello
I Wish to seek your conscience about something urgently, Please reply
this message, once you get it.
Yours sister,
Mrs.Elena Tudorie
Email: tudorie_elena@outlook.com
