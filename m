Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8206D08F0
	for <lists+linux-pm@lfdr.de>; Thu, 30 Mar 2023 16:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjC3O7V (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Mar 2023 10:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232611AbjC3O7N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Mar 2023 10:59:13 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D79A273
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2023 07:58:55 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-544f7c176easo359074067b3.9
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2023 07:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680188335;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AwZvoXv5Ik7M4dgOpEILycWjntmKDPLmuGuHDa/y93Q=;
        b=hvoIxo1To6KPMEfbaqMEIFHroev9LrGs0faSunEFSa9C3bGX4Gm4I0XTvfnPaymlpn
         2V74UXpHrg7lhv4J9aju1XnmnOZZkzsngXuf/dtPSyZrvW6kmYWXALTL7NjI+nR+B5go
         H5I2cTPaeAyNLi6ESs6rCrif4/G5m28Cg3QIZeQmpLZ2ElPkt82bJpQMudZQxOSsCVs0
         GOrxhP3VT/AoqxQVXXpCjFpeqFtGM+Sv5d3wLkL8OT6+ALBxldv9fmOWAfZYAys4haGF
         yqNcXk7jRQ4WZwz8tgu3mda7p6Ma72UgRunlIFv1rCeYccv9nrN4eAe5W+lg18o5rCer
         FE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680188335;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AwZvoXv5Ik7M4dgOpEILycWjntmKDPLmuGuHDa/y93Q=;
        b=gN4Xnpq71B/DkvsyZaNAIitANTZIlSWKtnhRseibFBnqo4xXndhIJK1Ed9J3b9DYtM
         KpqqXMygLVdy57D0BMN/wVQot98nfP1aZwYo+qCUX64ImD+ZR3ssDuvnLF6iBKhYTesP
         C1gsA/RCzDvllGR03S9G4YUeKkJ6/+O4x0/CxgoRNkCX+fLZbF/7AawE3iM+XI7qBZM4
         IfPYj7n74l6KyjMdxcXpLW1LF87ZPJi8MFPf5ADE0fnflr75a83mRG2FcBHHrd+jc55D
         0umuf3e/gTDm5ttQIzdecZ9HgDG0hvjST8PiS9/tDe2bQwIUCDLai8FN1YLk2tSvutC6
         Jd1w==
X-Gm-Message-State: AAQBX9dYy4JjJTmGfxtS5+rQXia8pB1/kUT99KGi1SOEoYyYOpCR+jFU
        E5iDa1kyL4q6+C6r5WysBzptRUzFL97tzN1yHIw=
X-Google-Smtp-Source: AKy350adbduzwsqT34Ik8vLNCGf8HbE1zRpj6ONG2dEXGngdSZlpdeXn7jJHF4TnUtnIJ2Y55oX+6C1TxGmHWu/L8bQ=
X-Received: by 2002:a81:b647:0:b0:534:d71f:14e6 with SMTP id
 h7-20020a81b647000000b00534d71f14e6mr11168764ywk.9.1680188334657; Thu, 30 Mar
 2023 07:58:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7010:4186:b0:32b:28c5:a477 with HTTP; Thu, 30 Mar 2023
 07:58:54 -0700 (PDT)
Reply-To: wormer.amos@aol.com
From:   Wormer Amos <fatimamuhammad5689@gmail.com>
Date:   Thu, 30 Mar 2023 14:58:54 +0000
Message-ID: <CA+QAR6V622vRkg=bDMDDXFHDck+0NBcdoretOfZSTzhwP4zw7Q@mail.gmail.com>
Subject: I WANT TO KNOW YOU,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUBJ_ALL_CAPS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Just want to know if you're ready for investment project in your country. i
need serious investment partnership with good background, kindly reply
me to discuss details immediately. i will appreciate you to contact me
on this email address Thanks and awaiting your quick response,

Yours
Wormer,
