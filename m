Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D021C1962
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 17:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgEAPYr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 11:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgEAPYq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 11:24:46 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2C6C061A0C
        for <linux-pm@vger.kernel.org>; Fri,  1 May 2020 08:24:46 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u16so47017wmc.5
        for <linux-pm@vger.kernel.org>; Fri, 01 May 2020 08:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:resent-from:resent-date:resent-message-id:resent-to
         :message-id:user-agent:date:from:to:cc:subject;
        bh=Zwbt4lmFAPn3PFdvyE+31G241RlC55gcnYxc2tQwA7g=;
        b=BEaU3Rp47tIf7mSF3VunOCEJ5IcI5dACF3g79kBFBMVVluXwc6mwozv6SJSwZNU8oR
         XEdNEwMmsKQV8kY9E0NpS4lu1hdDjYlOysTGZOkWK+UkuJLz33OLniuk8DZ7uZU2yi3C
         HGdO7zAxL0pNHK0gbavW6+IkdrfeCSQH/jCz6hYCy1+oAAOBuf830qwD71DZlKA2vP8P
         VBonWNGd4l8zJdjUMMx0IHJOFYIJd/TgfWipHyNDxJ1DpljHlppVK9W4FmOYPBySGv5u
         5XbBxzUrtDjPWDIij7COschW9iD/yYjelmslOk9bc2Y/9n/WYiwRxN+cIH+09HMunbfy
         6EDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:resent-from:resent-date:resent-message-id
         :resent-to:message-id:user-agent:date:from:to:cc:subject;
        bh=Zwbt4lmFAPn3PFdvyE+31G241RlC55gcnYxc2tQwA7g=;
        b=eM6GHwGDiMGjZLWveHetVWbUyIDdV3YV+sePTb7u/bpsDcnftK9EXOBt8rAGfZGyXu
         OMiSNrpAdTxXzVqpbncjvMLrelbYvtgQNXvOzrEaHbHDp8KVHtT4YGE4zuzmhyadVt64
         j0YAb22D3wu7OxRdLzWdH7knbHaYOGtpBLqjHtSPyi4AgExJmUUhQOZuXWfldpi2LAQT
         8dFu+vwNPDOS3D6fRYRUtnC+drafGNmqEh3U99NoJRJJoRNLpUTIaMVYRuWi3wFPSrPe
         LOnln3pJdtdq2Tes8l3VuTCrEqwe1qfIqb2UGjZR6Jp1ClWDEOBow4hO6dJni8y9DPCf
         HXRQ==
X-Gm-Message-State: AGi0PuYlGt87fGv4tLSpUKIW1e2SVtEYdMJuu7V3hRSRbJT+rGYZ8a0S
        QMTM++nSFpDez0BYw7Co0dQ=
X-Google-Smtp-Source: APiQypL+udRjogTIT+AYSAf0Dfc2V+BjyII3LEL0Fb8l8Hxd9nMQcoq/EJO1NGqVXI4oeMTGsLGeFg==
X-Received: by 2002:a1c:7212:: with SMTP id n18mr72623wmc.53.1588346683484;
        Fri, 01 May 2020 08:24:43 -0700 (PDT)
Received: from dumbo ([2a0b:f4c2::1])
        by smtp.gmail.com with ESMTPSA id n131sm49117wmf.35.2020.05.01.08.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 08:24:42 -0700 (PDT)
Received: from cavok by dumbo with local (Exim 4.92)
        (envelope-from <cavok@dumbo>)
        id 1jUXWq-0006YI-Vb; Fri, 01 May 2020 17:24:40 +0200
Message-Id: <20200501151452.621900831@gmail.com>
User-Agent: quilt/0.65
Date:   Fri, 01 May 2020 17:14:52 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: [PATCH v2 0/2] hibernate: add config option for snapshot device 
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Dear maintainers,

These are the improvements over v1 [0]:
  
 - move the mutual exclusion to hibernate.c (it was in user.c)
 - switched to refcount_t API (it was atomic_t)
 - the option is enabled by default (it was disabled by default)
 - remove the premature "DEPRECATED" marking
 - drop the redefinition of mutual exclusion helpers (in v2 they are
   owned by hibernte.c) in case the option is deselected
 - add the help message to the config option

Kind regards,
Domenico

[0] https://lore.kernel.org/linux-pm/20200413190843.044112674@gmail.com/

-- 
rsa4096: 3B10 0CA1 8674 ACBA B4FE  FCD2 CE5B CF17 9960 DE13
ed25519: FFB4 0CC3 7F2E 091D F7DA  356E CC79 2832 ED38 CB05
