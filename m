Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD2679E233
	for <lists+linux-pm@lfdr.de>; Wed, 13 Sep 2023 10:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238900AbjIMIe0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Sep 2023 04:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238880AbjIMIeZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Sep 2023 04:34:25 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B077AC3
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 01:34:21 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id af79cd13be357-76f066e4fffso410245685a.2
        for <linux-pm@vger.kernel.org>; Wed, 13 Sep 2023 01:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694594061; x=1695198861; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1PnWszoCToxYLRiO1oCHM1h1q5ty15QDle4iTdRe5Pg=;
        b=M6bK0LeeUoAmESTll5ANugbc2xX8u44C5KeGN/zm97qP0LjQnEFxSA1y/GhvthoTFd
         UEaOuSgKkHWzyJObOwtpl398NmOx5k+uex/wVFHHOcUYR9FLhyjsqs4jmy/vjZ0KEe6y
         BMGPILH2HyS/mM8zW32ZbGsZXON18CcDTBIm6xyed/BXl23SkzoeZRbqjreTvnvrKY+s
         z3xeRYw+zaNZcll93lIutLgn+N8uDnx/51GXNNlNcgRdUbpTuaR50CiJd/h+QW4oaAUL
         FM5/QZqOvnEUawvuGacAvm9Z225GXENOR9v6/RmWaK5jepoYUGlXhF1ClxvFX1iplYWE
         RtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694594061; x=1695198861;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1PnWszoCToxYLRiO1oCHM1h1q5ty15QDle4iTdRe5Pg=;
        b=W0GmfEmnsG5fqPSghP/JQTQs2VLj/Vq3hb2gHJglRb3qDt4DFEtCEKBci+jjen7lJU
         XtJcXbhUFrPE7kHd3F/HtWS9LrQXE83Q68A7JjRE5HXAmXa/arWZeT7pjXrJE0VTsVqY
         sW7o7dSOISoJ3dX+jAlkaeLgT7+1Lw0qm5D9GwgXKoMIfQ5vACcAWkn6XfWRFc05bn5c
         dy44AhQf6Ws9ubyBPXqPAZoZFKDsvb65jDX3ZFQyVPe19qYjhQxFGcegz2ZDIlC0uxqy
         VuRYHFsxqtUaL/i4eHNO/vOOSW6q9dRlr+mKH3Fm/lJ5/K2LIVu1BodDyJ7mP9ejawB9
         LRfA==
X-Gm-Message-State: AOJu0YzdHY/ddxk8aAEzC6rJbEzhSuBYmcPpT+f5K/Y9jgI9HkOzQ83K
        672zgZtf6geUUOx2WOFMJGnEo+sp19z+ZsIdEIA=
X-Google-Smtp-Source: AGHT+IFPoyplyfJgHFYVulijbXIpuVQfWZVmFz3qok4ndiX6Ick4O3deErhH8FrNUik6toRQWMv2JAjllkuwrRFt/R0=
X-Received: by 2002:a0c:cc92:0:b0:649:914:6495 with SMTP id
 f18-20020a0ccc92000000b0064909146495mr1838189qvl.62.1694594060693; Wed, 13
 Sep 2023 01:34:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:f587:0:b0:64f:9196:9ef3 with HTTP; Wed, 13 Sep 2023
 01:34:20 -0700 (PDT)
Reply-To: sigridrausing55@gmail.com
From:   Sigrid Rausing <puritywmbui@gmail.com>
Date:   Wed, 13 Sep 2023 01:34:20 -0700
Message-ID: <CAHcJPveBooDJGXxMc8X4DLjHOm9usFf0XZMs+z6re7CNd-xnew@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

-- 
Hello,

My name is Sigrid Rausing, A Swedish investor and philanthropist.

Your e-mail address was provided by Google Inc. randomly selected as
an active user on the web...

This year, I decided to donate 5 percent of my wealth to both
charities and individuals due to the coronavirus pandemic that has
paralyzed the whole world.

I am donating to you 1,000,000 Euros and I urge you to help someone
around you with the little you can.

For more information about me here is my Wikipedia below:
https://en.wikipedia.org/wiki/Sigrid_Rausing

Contact me on this email address: sigridrausing55@gmail.com for more information

Regards.
Sigrid Rausing
