Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1609C50EFB0
	for <lists+linux-pm@lfdr.de>; Tue, 26 Apr 2022 06:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242846AbiDZEVF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Apr 2022 00:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244070AbiDZEVF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Apr 2022 00:21:05 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDDE2E0BF
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2022 21:17:58 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id r12so18112281iod.6
        for <linux-pm@vger.kernel.org>; Mon, 25 Apr 2022 21:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=LkVzGmjin4oQm9POhirtBv43WQcTLvdJ9RmTDocLdTY=;
        b=NoYQO+N+pvIAZY44NBFB4SB+4uejGoZOKH6o5lQQ8O/8xDnHcPyVm6GpfoVDB6H9rq
         RU3G9no6Qv73tejYhiPbRchitOhg53tza5KX2DhM9hL+VRaotymOek+HMuG5B1LW20kb
         HBOaM9HsiqQWh9/a2CHNzkqdbPYaREpPDbjnYU9cRV36+tpDTGkY+gJceYW4k6cRJxfy
         qMXITvI71jVEL5f2GVnqbbpw06RQUbuUKRshgEYK3zOxD3NXssXv22qV18FCOzkrpKr/
         u++E5GhCl7bSHZg9RjEyGxhoBVPXjy8Wkfo+4OiCW/48uQqVcmav0hxOFB/5k4mubSPX
         0ovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=LkVzGmjin4oQm9POhirtBv43WQcTLvdJ9RmTDocLdTY=;
        b=zyd4wx8Ax1C51LjmrOHVkFu6bq5MJYf2T26VqOdaHkHuJrxFC9nQ9lDm9sySCP7XCk
         0OcklIgtcfg7zCa2hip8WnaVKIcMHXgoy1eHIddPwQr4SfE1Vm8V7vSbKFbv3jFDAf43
         NyeMc8s95Nhxp50iayNM9OH7xt6Ur+6A/gR0B23K8GvEDqhjlSHR2RI7cNeXeT94z+CX
         7dDhegJjrfyKi+e8M1j9wgW2yBmHDaa//VLWTvEtGiVv1Az+nEDGdXhTmUPsdaH+Cyj1
         3DNz6xiZoQPTSlmYO1W20nqfXgkx9BGCcZb7sETuE7E7ecBbrS7nCxb4Q7qkkBceXFBX
         XkHg==
X-Gm-Message-State: AOAM532lUeU56DT4Snc5N2LnInt/O7qrXyUA9d7cr1EYHlA0Rnld7awL
        u/9o0aS6LnwNDxRHVUnecsTAfJgpKBf0DZIJ90s=
X-Google-Smtp-Source: ABdhPJwInbbAFHLVlk7mWcgiGiLEkkW8GdQ/bRFo8XeJOJfNyghoh1XogAknmKRJsVAxP081pROOWMhf8jryeyCexro=
X-Received: by 2002:a05:6638:1a0f:b0:32a:98bb:64e4 with SMTP id
 cd15-20020a0566381a0f00b0032a98bb64e4mr8484103jab.38.1650946677864; Mon, 25
 Apr 2022 21:17:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6e02:1946:0:0:0:0 with HTTP; Mon, 25 Apr 2022 21:17:57
 -0700 (PDT)
Reply-To: mrskarimmikael@gmail.com
From:   "Mrs.Karine Mikael" <tepalmer2@gmail.com>
Date:   Mon, 25 Apr 2022 21:17:57 -0700
Message-ID: <CAG08HJe0y9FR4QGtqh3Y3X06fpXHZ7HhLdasoy8Kdkx3bUYf-A@mail.gmail.com>
Subject: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d2b listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tepalmer2[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tepalmer2[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hello
This is one bizarre letter all my years of existence, I got your
e-mail address online while searching for someone reliable that will
assist me to carry out an urgent  assignment.

I have been living with leukemia since I was 19 and fifteen years ago
was diagnosed with serious, adrenocortical carcinoma cancer, which has
rendered me utterly useless.

I will gladly give you more details on your responses to my  mail
Regards
Mrs. Karine Mikael
