Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73C6B2E0E4
	for <lists+linux-pm@lfdr.de>; Wed, 29 May 2019 17:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfE2PTn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 May 2019 11:19:43 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42827 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfE2PTm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 May 2019 11:19:42 -0400
Received: by mail-pl1-f193.google.com with SMTP id go2so1189624plb.9
        for <linux-pm@vger.kernel.org>; Wed, 29 May 2019 08:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1A7TCCgc5M7LrkbW+x271X+Y6YBGe6GwJjsMzpGZe9I=;
        b=Z8Tp+KrVyGUMMAEsQhbaQ2TDzEEz/uaEKxfWsEnJRn+nZQDSoINbyqGfWqt+ZYvVMW
         u+1Yo1fsE6I+VQn9Bd/KfVNUdSzL5PUw8wG6Ysh6zq8da7GaemN2701/H7lV5xvCUHNb
         /lChC6y7938xSxE9gKlWoqmU0ZbGa6bu0W6wKxW9ooCKlPGl7hfWfUuPY1pPXg0ns4gO
         XQaqYE7alv7ZDer8OOMA6T23Mp1g5VbUgtN57mmQrqY+rv/1Vs/FJPQEd6QpGksq/1mq
         JvbHodEmxcA58MBefGLRisV9oFjVm5P7MvOXVFcQUSJmH0qJlFcyIYIbArG2GgylEg2y
         SZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1A7TCCgc5M7LrkbW+x271X+Y6YBGe6GwJjsMzpGZe9I=;
        b=CrUzDVLhPyo5PHs+eNMtH+MIfE1ibydsCAMQCnLG1fK4iSITyqO8XBtxmNdSsV0uXO
         /qsR95Y3RPQAXu4MFUrkN6agqPYnLK1B2fEEGW2fPPoR23R1UKh20g8iRTVFX/CQeL9i
         PEL7Vl9F0fCUZvt4Wbt5bel2j14wikka+q6l93HyWoABNlCbCub3fCvMJrflYX51SuZ+
         WF6CL9maWeSOur9gC1CrLevtdcW3EQIuK6vswSkT52ccZspyqPnHftUJ3D/A568nYE4z
         qSrF15tQcF/9ZDs1gBQtGZj1oAorQH3yFz/4/YcNKFyCR9qvR5cNzkeWG+ONhE7ZMf5A
         7PNg==
X-Gm-Message-State: APjAAAVDCeQuxr9I3zm/EcqJkhPx25wOAV9XdkB5GsdEMoZ7eHb8831b
        LFLjt6kCDPfMYb++v95YGZ8=
X-Google-Smtp-Source: APXvYqyWhm4iWgmGXYjUZNYb1IGaMErr56TzCYiPSuDg54pYVL4P0z3kcbVOpcop3OzvVN29C3K+gg==
X-Received: by 2002:a17:902:f082:: with SMTP id go2mr132410616plb.279.1559143182238;
        Wed, 29 May 2019 08:19:42 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id t25sm33488515pfq.91.2019.05.29.08.19.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 08:19:41 -0700 (PDT)
Date:   Thu, 30 May 2019 00:19:38 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-nvme@lists.infradead.org, linux-pm@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH v3 1/3] nvme: Export get and set features
Message-ID: <20190529151936.GD28274@minwooim-desktop>
References: <1558888143-5121-1-git-send-email-akinobu.mita@gmail.com>
 <1558888143-5121-2-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1558888143-5121-2-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
