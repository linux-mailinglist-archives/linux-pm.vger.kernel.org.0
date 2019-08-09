Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF4288476
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 23:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfHIVRi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 17:17:38 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41881 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbfHIVRi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 17:17:38 -0400
Received: by mail-lf1-f68.google.com with SMTP id 62so65587959lfa.8
        for <linux-pm@vger.kernel.org>; Fri, 09 Aug 2019 14:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6qcKD1aVaygupbagJQvs2szHppirdYUK1GjYON7+Wc=;
        b=PZAf+XDThboVQRyYZztPO0KbXTs1zesXPlhPtOdK0cxWUGJAax/ZcgrlVtr+Flu12b
         LM63vttNkoeT5Zskzk7N+8pLvqMd4TuogzXoQ2gjJk1vVQfgsxf3f9vx0Q2iLXCcEOj0
         jvveAaMqqpP2Aa/Eyw+wy7Ba4XmwDB4MEXCmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6qcKD1aVaygupbagJQvs2szHppirdYUK1GjYON7+Wc=;
        b=gUGBS0zCicpMuOFAlURDr1cQog/xityeh6yoQ3c7I7nIv3iyX0juWGz9ZuDTCGaptd
         hsIvmGvFUunewICRT8fD+kZqbAtSykmNPZR/HHU4QXtSlBd+GqhLNMNsUaV2RGgt6HaJ
         PdfE/Mg3MigfVFYy1VRFbIlsWKuWLx7+OHbBC64gqgJ5ODNPinXWdIn3ow9PuXoF5zrl
         yb3OHHf9pjxdZpORsFQtj+ZZrQKMNmkS21qJHvAcgZn+/qVrWJYSoM/Joa3mnmhgQy7O
         GIjnVz4m/wASdTYRBQuhZl9Rt47ytMDvBjCxrx/mtv29ftOngGuqboHMnF8h9PI7G92D
         gyKw==
X-Gm-Message-State: APjAAAUGzFdwB+Pu9IImnzl6IZaa5cWz30nm/a/2R+q2Xmt4JBJ2nHFl
        583eQ189aPure1tFyKU/JikoePPVw7c=
X-Google-Smtp-Source: APXvYqyDr23x4r9HL1OjlpuygIBcNeoDVTsGJhRDyEBfwWw8E0M3anSf9Wz7mIqZo+4x3fGH1Gwmcg==
X-Received: by 2002:ac2:4242:: with SMTP id m2mr2218599lfl.121.1565385456205;
        Fri, 09 Aug 2019 14:17:36 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id k82sm19636377lje.30.2019.08.09.14.17.35
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 14:17:35 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id c19so70485814lfm.10
        for <linux-pm@vger.kernel.org>; Fri, 09 Aug 2019 14:17:35 -0700 (PDT)
X-Received: by 2002:a19:110:: with SMTP id 16mr14160555lfb.63.1565385454814;
 Fri, 09 Aug 2019 14:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190809121325.8138-1-georgi.djakov@linaro.org> <20190809121325.8138-2-georgi.djakov@linaro.org>
In-Reply-To: <20190809121325.8138-2-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 9 Aug 2019 14:16:58 -0700
X-Gmail-Original-Message-ID: <CAE=gft4mkz=rhmC7p903UuAhzG2obaST+ZTecOfmDFKbpgSTpg@mail.gmail.com>
Message-ID: <CAE=gft4mkz=rhmC7p903UuAhzG2obaST+ZTecOfmDFKbpgSTpg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] interconnect: Add support for path tags
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, David Dai <daidavid1@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, Doug Anderson <dianders@chromium.org>,
        Sean Sweeney <seansw@qti.qualcomm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 9, 2019 at 5:13 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Consumers may have use cases with different bandwidth requirements based
> on the system or driver state. The consumer driver can append a specific
> tag to the path and pass this information to the interconnect platform
> driver to do the aggregation based on this state.
>
> Introduce icc_set_tag() function that will allow the consumers to append
> an optional tag to each path. The aggregation of these tagged paths is
> platform specific.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
