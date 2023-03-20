Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E8E6C1CF7
	for <lists+linux-pm@lfdr.de>; Mon, 20 Mar 2023 17:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjCTQ43 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Mar 2023 12:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233131AbjCTQye (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Mar 2023 12:54:34 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271BD367ED
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2023 09:46:24 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id t14so12788078ljd.5
        for <linux-pm@vger.kernel.org>; Mon, 20 Mar 2023 09:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679330775;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebEOfpRXdHWY9ycpXGKvSUp16AC2xEFrZPbwbiRK63U=;
        b=n5NFZEzc2S+kGmxGGHu81LNWnQ0OHxWgVoUIKprEF3Huc/hnvhLz/t/QxukURkLFN2
         taml1WRXm7CaKp7n9qsIJxx63pn1DebRZxzVz6ErGvxGbp5xMktTBNtf2hZXLzrf4Saq
         xJKB+7qc7WpSgzd5E1JUqUVwPAk5XTbcKmx1vH3yYsZGgzKgltRl0nBZlXDWfcv8NX5P
         OohaPfiiJWQ3evVEA+nkwxdKUEFeqssvRu4Nv9HoyTbBpfmA47rFSwKe0v7cw/6Dnf+c
         frZ6R9tIotoWmg/D8bm0FQAny8pnERQ3TQ7SBM7GTcV/gaZqlz0zxtBTa0cqPQGdyynf
         Fkdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679330775;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ebEOfpRXdHWY9ycpXGKvSUp16AC2xEFrZPbwbiRK63U=;
        b=ahSoAAfie1ap2SKPLJHL56n+R0bfhCTIe4ZA18Je/TrgyORkI19ecGMIs0CgBX3E9m
         tHSGLRRN43kfVERrF7FqbUOoMVAwRJIi3j2C1ooen+k2CyBDm7g3l1WB+/PiEMQcvEkW
         9opK+lhiVeQ/A2IjzoEQmewibT4WAopmMkxu3Eb8ArTYRfa2GCZRepbwwoiDz1Iis5zm
         gS/k1jAww2XzUpfHoKEHZnJhhi2IYrkXCRRWwQ2K1f4VGF1QMr1iXtyyNApAP5pPBQuk
         vCyvbKGrKKyOnrzWB/KRhUaz4PQB9DcUhQC+eedmepMF1tcGm+MQRfQHy7FSnK0kRnfc
         yjCw==
X-Gm-Message-State: AO0yUKUjTAPsx2nZ30XOhkLnj0YMbE7Fy+Wz71NsoQ7aZ/a31zYJjAz8
        Z6RpgoNjvoDPuz7HIsVax7Itvkq1NkQrV375F4w=
X-Google-Smtp-Source: AK7set9x/YqDlJSt2+XxJG8OtNt1BEJ8bNTJY3bjPR2sAJx4w50iUIhwsC3eKAPU/9a90gKKW6OcNLav06ygMH0LZGw=
X-Received: by 2002:a2e:9d42:0:b0:299:9de5:2f05 with SMTP id
 y2-20020a2e9d42000000b002999de52f05mr214766ljj.2.1679330775591; Mon, 20 Mar
 2023 09:46:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab2:65dc:0:b0:1b1:7295:6fa8 with HTTP; Mon, 20 Mar 2023
 09:46:14 -0700 (PDT)
Reply-To: sharharshalom@gmail.com
From:   Shahar shalom <chifomueoji1@gmail.com>
Date:   Mon, 20 Mar 2023 16:46:14 +0000
Message-ID: <CAOEuvMFCH0Bzg=th0JsL+8PXUbz3One=AZpsxaS5y9zM-LZ0Jg@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

-- 
A mail was sent to you sometime last week with the expectation of
having a return mail from you but to my surprise you never bothered to replied.
Kindly reply for further explanations.

Respectfully yours,
Shahar shalom
