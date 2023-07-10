Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3831174D267
	for <lists+linux-pm@lfdr.de>; Mon, 10 Jul 2023 11:58:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjGJJ64 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 10 Jul 2023 05:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjGJJ60 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Jul 2023 05:58:26 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612883AA7
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2023 02:55:21 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 5614622812f47-3a1ebb79579so3288804b6e.3
        for <linux-pm@vger.kernel.org>; Mon, 10 Jul 2023 02:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688982920; x=1691574920;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=or9KDjpUn1ZXN6JFqu4Im7a65zY/0cqAMSkz3dts6Ts=;
        b=Sbat3jfMUUix6MybKcxwhjd2APH5OY0ZdBV4CaeoGNScR1KqSyOAF2zuJG6y47U83m
         kUg4+UwUQh98QChNVW2Xwrqok8WnNXqwkpn7u8YA2Q17al7HjcFvo7DScvWE1VFFsJkG
         Qk61HEWSwKNkIzSJXNiybxal0CQFlJBkH4u6TC67cpppd0yw6yvGn3NCkz2cMq1ue2PT
         QF8jPpZlG36B4jRo028cOmBdep246XgraO1ejc2SsE+HTYsR15AoBZJt2gWdU6vV0Z9k
         edG4RKHyp7JJf0OsksFM+U0QaS2pzELxxLn0htVMTescOL1N5KxIMUg3IsI+frB2CuJp
         kitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688982920; x=1691574920;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=or9KDjpUn1ZXN6JFqu4Im7a65zY/0cqAMSkz3dts6Ts=;
        b=ACKlVskAQyBlhN6qFX3pNveBhPtHICNzeEC/HF0HMZ2L7vxc4F07wjNHdAO5DrpiWa
         HNMHSNWGu9RYyNZhVHGn27UsD42zSKrBkuTxvdL5VMJcPX2GwjgWXFP+2GV4uP4nmPYg
         Y/pKZEcgHr+VrQ3I5wrBWSR5CbcTMDrXuiztiVbtOOKaFyekIeTz8uWcym3Rp/o14h0g
         Mt9gqy/snGgHlCtvXgoXs9ms5QfcZk/ATUlKyCj9/CYMvwf3YeYnKTM/5KSLxhvKgxkX
         NGvPzrhNHnq8TTBzL4vSH8KclUW9Z+tGAIYSYUbDG+gN+VoPxOEN21+NAlTltOxzCASZ
         lcog==
X-Gm-Message-State: ABy/qLaQjqmw38Br3i6/YIRPXSv/Ocdh55HZZccm6vR+qLnfkWyB7NCg
        fZRSLTtFA6DehY8M+Mcrfe40Gpxge2C+q/6VKhE=
X-Google-Smtp-Source: APBJJlHrygxfv/hbiJf1s8v8VcOLFLp7CpfwBfOxrSbzSiiPR1LvItCBI+cpUttcm1fP9401mUtgalirpsv5iy920C0=
X-Received: by 2002:a05:6808:151e:b0:3a3:6382:b67d with SMTP id
 u30-20020a056808151e00b003a36382b67dmr14265649oiw.41.1688982920574; Mon, 10
 Jul 2023 02:55:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6358:9886:b0:116:4bdc:eaff with HTTP; Mon, 10 Jul 2023
 02:55:20 -0700 (PDT)
Reply-To: sar24104@gmail.com
From:   Jacob Kriek <dmonigdept@gmail.com>
Date:   Mon, 10 Jul 2023 02:55:20 -0700
Message-ID: <CAGO6Ue-NqhnCWsgbEcWcsKoanxW-J5qePFQx7d9+SAzSioRqtg@mail.gmail.com>
Subject: Great opportunity awaits you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

-- 
Hello, I have an important information that will interest you and
benefit you the most, get back to me if you are interested in the
information. Jacob
