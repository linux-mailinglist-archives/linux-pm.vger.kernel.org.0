Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B144BF80C
	for <lists+linux-pm@lfdr.de>; Tue, 22 Feb 2022 13:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiBVM2H (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 22 Feb 2022 07:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiBVM2G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Feb 2022 07:28:06 -0500
Received: from mail-yw1-x1142.google.com (mail-yw1-x1142.google.com [IPv6:2607:f8b0:4864:20::1142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 760966F4A4
        for <linux-pm@vger.kernel.org>; Tue, 22 Feb 2022 04:27:40 -0800 (PST)
Received: by mail-yw1-x1142.google.com with SMTP id 00721157ae682-2d6d0cb5da4so116518417b3.10
        for <linux-pm@vger.kernel.org>; Tue, 22 Feb 2022 04:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=xVJHepNq93ePmAbCv1LHbdOWJcqWYQh8v11fr0KUdVw=;
        b=RltRUuEz8qTFSSDlLGIrW17zY6vkj/WiZwk/2DEws0fCs/4S/lZgH7OjKCucY+P9rc
         PpZSO1MJs+RPLStTXXHm0UvtzMrkNk0vGMEm4nywE6+G6lkgDBgjCIo9+w3vOdi8Sor/
         V0PD5UAmPtH/oZ3oAyziUzVXc0pnF/o76H6Jse+bevHTbbBo1VP8yZOQITNLqWtRqYJH
         RNTK3BXyYsuVTedkMfcic0HvXkxRMwYM7n5FD9aiUftk8RfBf+RRJV04ParnSV7tcHDk
         d27MFGrGBs74FMu6/JZ6nw0qLAGsLSuavAJXEsvOOI5UCeKWgNG8XUYeMS+sswfKrmjm
         ggmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=xVJHepNq93ePmAbCv1LHbdOWJcqWYQh8v11fr0KUdVw=;
        b=yPXd5WHR+kxxX+tN5Nun4CGbCLNtdXa1ncNhMfsiDIpXoYf9ci8vfgNn1uR30fggu7
         caW8sAxRM/nV2cSgBzzaAHhovJtCqAjfxnqtX+0CCpWUCdMG4coIu7ozl4tlgNDiFz8N
         3KvVRBx6elOkLjlzUKz3cD0fVHJrhp88kyLnJRBBUFdQ8oswqD+D7vDaL8SLy4zOd0zC
         052NREKuFf7C/eZcDBhDuBFWgTT+Xk9wV5a0DSc2pDyszIYy+ko8PBGsxrM/o1lOEfwS
         YkYRSRD5lQqSnhCD9UZXBi/hrtk6UB8QmEvBDK3E5+xzkkKv+/reVSt0ME0LIeXNcdBW
         0NVQ==
X-Gm-Message-State: AOAM530s7c+cAagtDoQLwv0MnUaMrQY4UVeW3gXACZ25AyIigr4Ly7fO
        xpWniiLBSf/tyDIjRfdR7Wlhso0xIREs98+P8zY=
X-Google-Smtp-Source: ABdhPJzRoBykVu7xnpnnBjdEOY9arVZihjzBMwHAaeshpqP+pSt9pNC6/J+/AMp+3dJehh+CBWgxpq+/O4zotq/f1CQ=
X-Received: by 2002:a81:5591:0:b0:2ca:287c:6c8a with SMTP id
 j139-20020a815591000000b002ca287c6c8amr23735902ywb.303.1645532858985; Tue, 22
 Feb 2022 04:27:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:48d0:b0:210:a074:c1c3 with HTTP; Tue, 22 Feb 2022
 04:27:38 -0800 (PST)
Reply-To: lilywilliam989@gmail.com
From:   Lily William <marvelouschinaza54@gmail.com>
Date:   Tue, 22 Feb 2022 04:27:38 -0800
Message-ID: <CAE53ddZS_x-v=CDAXwUoU+KzL-ZiH4r9pHYQ4ZJ+VJFjShuLkA@mail.gmail.com>
Subject: Hi Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1142 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4462]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [marvelouschinaza54[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lilywilliam989[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [marvelouschinaza54[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

-- 
Hi Dear,

My name is Lily William, I am from the United States of America. It's my
pleasure to contact you for a new and special friendship. I will be glad to
see your reply so we can get to know each other better.

Yours
Lily
