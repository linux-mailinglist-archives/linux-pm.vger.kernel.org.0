Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26E637321B
	for <lists+linux-pm@lfdr.de>; Tue,  4 May 2021 23:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhEDV6K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 May 2021 17:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbhEDV6J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 May 2021 17:58:09 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93629C06174A
        for <linux-pm@vger.kernel.org>; Tue,  4 May 2021 14:57:13 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id i26so317738oii.3
        for <linux-pm@vger.kernel.org>; Tue, 04 May 2021 14:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h6nDWrO9L8CxbAXjtDgqv4B1xC4L9HAr7ltSEuwJLk8=;
        b=lp8Ds+q4uHoTq/2xNdc6nB8zMv9+EVRduoGZhmPcTiX40X3BRyVq20/wmbznOaJKXk
         48InIae6D+ySRAWfUzgcwxVE0xLGPx4ZpJGtdte6bTc/hYHkp3FD8UDSB6B4obl0gPal
         6Anx4jvxkyiRcU36eEj3cO21HPg5+rRJm7jyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h6nDWrO9L8CxbAXjtDgqv4B1xC4L9HAr7ltSEuwJLk8=;
        b=ZSgHlLrWC2+Gio3YgjfZUTukyRGO7KIV/ltaOs+H5tpep7+VZ+LWZTNGD9x+7z4wfV
         W7GK5rBZdjWZFZh/Ub1nDhnpqzMpnBJwJMkuEYww/62soFQb6bvIfXGpV8ITx0Orth9A
         KHwvQaV8UrbiBnkmu4jRrfPvzc7zM1Dd1ZP9f8cmDhGd4zl9Tnk+091mr5+a0CM58eHP
         ScvisRp5kKVHgbR0/m37PSuFrK9ki8yRX0l2l6xxBALSpMTZCxdySCQQYqdWFWVCLXZi
         4yvvhYDBGAONvFo509Kn/6GW6G360nOpwwJv8LKTPHQ9WzNBALjv8Kv2FEn440SmG3iO
         ou0Q==
X-Gm-Message-State: AOAM531pyYGvSgRvV2XOXqy9TbPmK6Jqq5WoqBQRAKqXjs5FtXZ30Ro0
        1IoQWuvy4DACsBE3mZKI8ce2a7+gM52wkE/T
X-Google-Smtp-Source: ABdhPJwxNHRLpsQKd6OZvseDTeKzyjqA890/DQXStaICZGkAu7I3FiWCp8z4XdrUkDPB8dYG19rD5Q==
X-Received: by 2002:aca:a88a:: with SMTP id r132mr3311742oie.86.1620165432802;
        Tue, 04 May 2021 14:57:12 -0700 (PDT)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com. [209.85.210.51])
        by smtp.gmail.com with ESMTPSA id p11sm1034877oti.53.2021.05.04.14.57.11
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 14:57:12 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so5663829otp.11
        for <linux-pm@vger.kernel.org>; Tue, 04 May 2021 14:57:11 -0700 (PDT)
X-Received: by 2002:a05:6830:a:: with SMTP id c10mr21052802otp.21.1620165431621;
 Tue, 04 May 2021 14:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210220013255.1083202-1-matthewgarrett@google.com>
In-Reply-To: <20210220013255.1083202-1-matthewgarrett@google.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 4 May 2021 14:56:35 -0700
X-Gmail-Original-Message-ID: <CAE=gft4HnQKP3RK1hOGpThccLPanQzWpssCsEyUQGLbTMpzrFw@mail.gmail.com>
Message-ID: <CAE=gft4HnQKP3RK1hOGpThccLPanQzWpssCsEyUQGLbTMpzrFw@mail.gmail.com>
Subject: Re: [PATCH 0/9] Enable hibernation when Lockdown is enabled
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-integrity@vger.kernel.org, linux-pm@vger.kernel.org,
        keyrings@vger.kernel.org, zohar@linux.ibm.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, jarkko@kernel.org,
        Jonathan Corbet <corbet@lwn.net>, rjw@rjwysocki.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Does anyone know if this series is abandoned, or is Matthew planning
to do another spin? Email to matthewgarrett@google.com bounces.

-Evan
