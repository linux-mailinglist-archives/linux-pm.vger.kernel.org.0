Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA4D8BF9E
	for <lists+linux-pm@lfdr.de>; Tue, 13 Aug 2019 19:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfHMR2g (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 13 Aug 2019 13:28:36 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42355 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfHMR2g (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2019 13:28:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id t12so18562885qtp.9
        for <linux-pm@vger.kernel.org>; Tue, 13 Aug 2019 10:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yv80EgLntszbP6TTSuSNcZVmW18fS3ZlkdDQEp8VgVs=;
        b=lqt/2/49srXKrh03BepDy8ewMxZilLS+HF5Q8tjtdHvoJ25v94i337rLbGfBQBoz/j
         5uYxhwEWDC8JbXTGO2wGuWUVicwKMYYnHxP/T3omg+jGHWt24eTisq6cOOxrucgpbgSh
         8Mb/Awr7Rmu8FNYwp+TcxQa6QTZClGnK11eXgIW5t/08reYP4+p1NqlrgI23LOM0GHo8
         n7d81aO680+1ETTNoz6Wa61+xadQDDkvkchWGDNhievj3RYAfSAZreip61Gfk44AZ1jB
         YwiKiYEcLje4kz8vDVfAsbXgTFXB7fDxFacz9pKXyv8gEhsUDse/aDpxMvCISOtnoNYG
         3pZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yv80EgLntszbP6TTSuSNcZVmW18fS3ZlkdDQEp8VgVs=;
        b=YTc5IaVotdthFUMCX9mSyxSc/zAiMaX1koZrb6DBG9sjPyglUorHXrr9iiKlCgHpIu
         VDtrrXvXxQa+0R0V2Vx6KHq2XWtLsf+j+VvTsQJcN/rS8k/wiAKbgBBSj0Pu3kMCxJQ5
         +nePSxkxYeMsveCNmSl7TSk+cIx9631efvNh2oK4E0SI1P4nNywxeBkZH0ZO5+oxJxBC
         zY5D46DvT8uWvjneMPp+nXXFlqsfIVxPB84cpIc3J/4ey1lJiRB8SIYQ4dbdrKDSuWDR
         jVGash5qb+LM4/MRhON7nGrR8OgHRg6acIhfwfoQQryMNjdDm14tdceJXSF3cVFMuQyZ
         b4Xw==
X-Gm-Message-State: APjAAAWWa/X6T+aWvyLAaJJ1JVL3Q7/lFRdxDXKAZUBnc5xY81MOABd4
        O6qUYHXIGUSud5jUTe12ijYHssk/Gs7gIHEB0QYKGA==
X-Google-Smtp-Source: APXvYqwjzhV0kDofeJYBNfZiu4sKgLdBAjdHPNSXHEraksdZW2nTzfcS4y9kTvM4BM8tj6/KYmHQMElrErf5PqkmmgQ=
X-Received: by 2002:ac8:6c9:: with SMTP id j9mr3573806qth.76.1565717315175;
 Tue, 13 Aug 2019 10:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190613184923.245935-1-nhuck@google.com> <27428324-129e-ee37-304a-0da2ed3810a0@linaro.org>
In-Reply-To: <27428324-129e-ee37-304a-0da2ed3810a0@linaro.org>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Tue, 13 Aug 2019 10:28:24 -0700
Message-ID: <CAJkfWY4X-YwuansL1R5w0rQNmE_hVJZKrMBJmOLp9G2DJPkNow@mail.gmail.com>
Subject: Re: [PATCH] thermal: armada: Fix -Wshift-negative-value
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     miquel.raynal@bootlin.com, rui.zhang@intel.com,
        edubezval@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Following up to see if this patch is going to be accepted.
